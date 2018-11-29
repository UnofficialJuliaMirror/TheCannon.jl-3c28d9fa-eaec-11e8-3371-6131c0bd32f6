using Test, Statistics, TheCannon

@testset "All Tests" begin

    @testset "label projection" begin
        labels = Float64.([1  2  3 ; 2  3  4])
        plabels = Float64.([1  1  2  3  1  2  3  4  6   9;
                            1  2  3  4  4  6  8  9  12  16])
        @test project_labels(labels) ≈ plabels
        @test project_labels(labels;quadratic=false) == Float64.([[1 1 2 3];[1 2 3 4]])
        @test project_labels(labels;zeroth=false) == plabels[:, 2:end]
        @test project_labels(labels;quadratic=false, zeroth=false) == Float64.([[1 2 3];[2 3 4]])
    end

    @testset "single star label projection" begin
        @test project_labels([1., 2., 3.]) == Float64.([1,1,2,3,1,2,3,4,6,9])
        @test project_labels([1., 2., 3.]; quadratic=false) == Float64.([1,1,2,3])
        @test project_labels([1., 2., 3.]; zeroth=false) == Float64.([1,2,3,1,2,3,4,6,9])
        @test project_labels([1., 2., 3.]; quadratic=false, zeroth=false) == Float64.([1,2,3])

    end

    @testset "projected size" begin
        @test projected_size(10) == 66
        @test projected_size(10;zeroth=false) == 65
        @test projected_size(10;quadratic=false) == 11
        @test projected_size(10;quadratic=false, zeroth=false) == 10
    end

    @testset "deprojected size" begin
        @test deprojected_size(66) == 10
        @test deprojected_size(65; zeroth=false) == 10
        @test deprojected_size(11;quadratic=false) == 10
        @test deprojected_size(10;quadratic=false, zeroth=false) == 10
    end

    @testset "label standardization" begin
        L = [1 2 3;4 5 6]
        nL, pivots, scales = standardize_labels(L)
        @test pivots ≈ [2.5, 3.5, 4.5]
        @test scales ≈ fill(2.1213203435596424, 3)
    end

    @testset "label unstandardization" begin
        L = rand(4, 5)
        @test L ≈ unstandardize_labels(standardize_labels(L)...)
    end
end
