task automatic  compare_memory;
    input   [32-1:0]    addr1;
    input   [32-1:0]    addr2;
    input   [32-1:0]    size;           // In Bytes
    begin
        integer             i;
        integer             error_num;
        $display("addr1: 0x%8h", addr1);
        $display("addr2: 0x%8h", addr2);
        error_num = 0;
        // Correctance Check
        for (i=0; i< size; i=i+4)
        begin
            //$display("Addr 0x%4h, written 0x%8h, read 0x%8h", i, ext0.ext_sram.mem[(addr1+i)>>2], ext0.ext_sram.mem[(addr2+i)>>2]); //FIXME
            if ( MEMORY.mem[(addr1+i)>>2] === MEMORY.mem[(addr2+i)>>2] )
            begin
                error_num = error_num;
                $display("Correct: Addr 0x%4h, written 0x%8h, read 0x%8h", i, MEMORY.mem[(addr1+i)>>2], MEMORY.mem[(addr2+i)>>2] );
            end
            else if ( MEMORY.mem[(addr1+i)>>2] != MEMORY.mem[(addr2+i)>>2] )
            begin
                $display("Error Found: Addr 0x%4h, written 0x%8h, read 0x%8h", i, MEMORY.mem[(addr1+i)>>2], MEMORY.mem[(addr2+i)>>2] );
                error_num += 1;
            end
            // Should use triple equality (===) for debugging the X state
            else if ( |MEMORY.mem[(addr1+i)>>2] === 1'bX || |MEMORY.mem[(addr2+i)>>2] === 1'bX )
            begin
                $display("ERROR: X found @ Addr 0x%4h, written 0x%8h, read 0x%8h", i, MEMORY.mem[(addr1+i)>>2], MEMORY.mem[(addr2+i)>>2]);
                error_num += 1;
            end
        end
        if (error_num == 0) begin
            $display("Comparison Test PASS");
        end
        else begin
            $display("Comparison Test FAIL (# of Error: %d/%d)", error_num, size>>2);
        end

    end
endtask
