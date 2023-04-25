# PlutoArgs.jl

A tiny library that can wrap PlutoUI.jl elements so they can be used as command line arguments as well if the notebook is run directly from CLI.

### Usage

The notebook `run_in_pluto_or_cli.jl` has a few examples that you can try.

```
@bind enabled Arg("enabled", CheckBox())
@bind vegetable Arg("vegetable", MultiSelect(["potato", "carrot", "beetroot"]); required=false)
```

Run this in Pluto to get UI controls, or from the CLI like this:
```
julia <path to script> --enable true --vegetable potato carrot
```

### Caveats

- Using a self-cooked argument parsing that will probably break sometimes
- One generic small function for all elements, so probably won't always work as expected
- No argument overview or help text, as everything is dynamic
- Arguments are not (yet) validated but will be once Pluto supports `validate_value`
