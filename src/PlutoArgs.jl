module PlutoArgs

export Arg

using AbstractPlutoDingetjes

function self_cooked_arg_extract(type::Type, arg_position::Int, args)
    # TODO: Use types in a smarter way, this is bad :-(
    if type <: Number
        return parse(type, args[arg_position])
    elseif type <: Vector
        values = []
        i = arg_position
        while i <= length(args) && !startswith(args[i], "-")
            push!(values, self_cooked_arg_extract(eltype(type), i, args))
            i += 1
        end
        return convert(type, values)
    elseif type === Nothing
        return args[arg_position]
    else
        return convert(type, args[arg_position])
    end
end

function lookup_in_args(names::Vector{String}, type::Type, args)
    value = nothing
    for i in eachindex(args)
        if args[i] in names
            if i + 1 > length(args)
                throw(ArgumentError("No argument provided for $name"))
            else
                if value !== nothing
                    throw(ArgumentError("Two arguments provided for $(args[i])"))
                end
                try
                    value = self_cooked_arg_extract(type, i + 1, args)
                catch e
                    @error "Parsing the argument for $(args[i]), which should be of type $type, resulted in an error:"
                    rethrow(e)
                end
            end
        end
    end
    return value
end

struct ArgPlaceholder{X}
    x::X
end

"""
    Arg(name::String, element; required=true, short_name=nothing, type=nothing)

Construct a wrapper around a Pluto element that is a CLI option called
--<name> if not run from Pluto.

Keyword arguments:
- `required`: if passing this option is required if running from CLI. If
    `required == false` and the option is not passed, the `initial_value`of the 
    PlutoUI element will be taken.
- `short_name`: the single-dashed short cli name, if you pass "k" it will be -k
- `type`: override type to convert the CLI argument into, if `nothing`, the type of
    `initial_value` will be considered
- `args`: CLI args (defaults to `ARGS`)
"""
function Arg(name::String, element; required=true, short_name=nothing, type=nothing, args=ARGS)
    if AbstractPlutoDingetjes.is_inside_pluto()
        return element
    end
    initial_value = AbstractPlutoDingetjes.Bonds.initial_value(element)

    names = ["--" * name]
    if short_name !== nothing
        push!(names, "-" * short_name)
    end

    required_type = type === nothing ? typeof(initial_value) : type
    arg = lookup_in_args(names, required_type, args)
    if required && arg === nothing
        throw(ArgumentError("Argument --$name is required but not provided (use --$name <value>)"))
    end
    if !required && arg === nothing
        arg = initial_value
    end
    # TODO: Uncomment this once validate_value is supported. Make sure you also uncomment the tests
    # if !AbstractPlutoDingetjes.Bonds.validate_value(element, arg)
    #     possible_values = AbstractPlutoDingetjes.Bonds.possible_values(element)
    #     throw(ArgumentError("Value of --$name is invalid. Possible values: $possible_values (generated from $element)"))
    # end

    return ArgPlaceholder{typeof(arg)}(arg)
end

Base.get(arg::ArgPlaceholder) = arg.x

end # module PlutoArgs
