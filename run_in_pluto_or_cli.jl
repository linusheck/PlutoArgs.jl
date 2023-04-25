### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 86a2e8c6-bcba-4e77-bd23-42164e6a1942
using Pkg; Pkg.activate(".")

# ╔═╡ 2d518ad6-e352-11ed-31df-b9a339e02b37
using PlutoArgs, PlutoUI, Revise

# ╔═╡ f1cdf3fe-7a99-4b30-a365-de1403ad5d04
@bind width Arg("width", Slider(1:10))

# ╔═╡ 2862d241-ece1-407f-bd16-703ae05a48b2
@bind enabled Arg("enabled", CheckBox())

# ╔═╡ fe8b5410-8b5f-449d-833f-24afdc1db7eb
@bind text Arg("text", TextField(default="Hello World!"); required=false)

# ╔═╡ 446a8b79-f158-4d59-99be-9267c93553ab
@bind vegetable Arg("vegetable", MultiSelect(["potato", "carrot", "beetroot"]))

# ╔═╡ bf60eaae-3793-44ae-a8ff-b10ec23112d6
println((width=width, enabled=enabled, text=text, vegetable=vegetable))

# ╔═╡ Cell order:
# ╠═86a2e8c6-bcba-4e77-bd23-42164e6a1942
# ╠═2d518ad6-e352-11ed-31df-b9a339e02b37
# ╠═f1cdf3fe-7a99-4b30-a365-de1403ad5d04
# ╠═2862d241-ece1-407f-bd16-703ae05a48b2
# ╠═fe8b5410-8b5f-449d-833f-24afdc1db7eb
# ╠═446a8b79-f158-4d59-99be-9267c93553ab
# ╠═bf60eaae-3793-44ae-a8ff-b10ec23112d6
