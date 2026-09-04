module traffic_light_tb;

    logic clk;
    logic reset;

    logic red;
    logic yellow;
    logic green;

    // Instantiate the traffic light controller
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Clock generation
    initial
    begin
        clk = 0;

        forever #5 clk = ~clk;
    end

    // Test sequence
    initial
    begin
        // Reset
        reset = 1;

        #10;

        // Release reset
        reset = 0;

        // Run simulation
        #300;

        $finish;
    end

endmodule