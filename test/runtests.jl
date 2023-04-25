using PlutoArgs, Test, PlutoUI, AbstractPlutoDingetjes

@testset "CorrectArgs" begin
    @test Base.get(Arg("num", Slider(1:10), short_name="n", args=["--num", "5"])) == 5
    @test Base.get(Arg("num", Slider(1:10), short_name="n", args=["-n", "5"])) == 5
    @test_throws ArgumentError Base.get(Arg("num", Slider(1:10), short_name="n", args=["-n", "hi"]))
    @test_throws ArgumentError Base.get(Arg("num", Slider(1:10), short_name="n", args=["-n", "4", "-n", "4"]))
    @test_throws ArgumentError Base.get(Arg("num", Slider(1:10), short_name="n", args=["-n", "4", "--num", "4"]))
    # TODO Uncomment once validation works
    # @test_throws ArgumentError Base.get(Arg("num", Slider(1:10), short_name="n", args=["-n", "11"]))
    
    @test Base.get(Arg("text", TextField(default="Hello World!"), required=false, args=[])) == "Hello World!"

    @test Base.get(Arg("vegetable", MultiSelect(["potato", "carrot", "beetroot"]), args=["--vegetable", "potato", "beetroot", "-n", "5"])) == ["potato", "beetroot"]
    @test Base.get(Arg("letter", Radio(["a", "b", "c"]), args=["--letter", "c"], required=false)) == "c"
end