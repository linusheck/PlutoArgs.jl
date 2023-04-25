# PlutoArgs.jl

A tiny library that can wrap PlutoUI.jl elements so they can be used as command line arguments too.

### Usage

Wrap `Arg(<option name>, <control element>)` around your control elements.

```
@bind enabled Arg("enabled", CheckBox())
@bind vegetable Arg("vegetable", MultiSelect(["potato", "carrot", "beetroot"]); required=false)
```

Run this in Pluto to get UI controls, or from the CLI like this:
```
julia <path to script> --enabled true --vegetable potato carrot
```

All `Arg` keywords (see docstring for more info)
```
    Arg(name, element; required=true, short_name=nothing, type=nothing)
```

### Sample notebook

The notebook `run_in_pluto_or_cli.jl` has a few examples that you can try.

### Caveats

- Using a self-cooked argument parsing that will probably break sometimes
- One generic small function for all elements, so probably won't always work as expected
- No argument overview or help text, as everything is dynamic
- PlutoArgs does not complain if an argument doesn't exist, because it might be needed later
- Arguments are not (yet) validated but will be once Pluto supports `validate_value`
