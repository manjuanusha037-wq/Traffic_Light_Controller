module traffic_light (
    input  logic clk,
    input  logic reset,

    output logic red,
    output logic yellow,
    output logic green
);

    // FSM states
    typedef enum logic [1:0] {
        RED,
        GREEN,
        YELLOW
    } state_t;

    // State register
    state_t state, next_state;

    // Register to count clock cycles
    logic [3:0] count;

    // State register
    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            state <= RED;
            count <= 0;
        end
        else
        begin
            state <= next_state;
            count <= count + 1;
        end
    end

    // FSM - Next state logic
    always_comb
    begin
        case (state)

            RED:
            begin
                if (count == 4)
                    next_state = GREEN;
                else
                    next_state = RED;
            end

            GREEN:
            begin
                if (count == 4)
                    next_state = YELLOW;
                else
                    next_state = GREEN;
            end

            YELLOW:
            begin
                if (count == 4)
                    next_state = RED;
                else
                    next_state = YELLOW;
            end

            default:
                next_state = RED;

        endcase
    end

    // Output logic
    always_comb
    begin
        red    = 0;
        yellow = 0;
        green  = 0;

        case (state)

            RED:
                red = 1;

            GREEN:
                green = 1;

            YELLOW:
                yellow = 1;

        endcase
    end

endmodule