BOARD=tangnano9k
FAMILY=GW1N-9C
DEVICE=GW1NR-LV9QN88PC6/I5

all: main.fs

# Synthesis
main.json: main.v uart.v calculator.v
	yosys -p "read_verilog uart.v calculator.v main.v; synth_gowin -top main -json main.json"

# Place and Route
main_pnr.json: main.json
	nextpnr-gowin --json main.json --write main_pnr.json --freq 1 --device ${DEVICE} --family ${FAMILY} --cst ${BOARD}.cst

# Generate Bitstream
main.fs: main_pnr.json
	gowin_pack -d ${FAMILY} -o main.fs main_pnr.json

# Program Board
load: main.fs
	openFPGALoader -b ${BOARD} main.fs -f

# Cleanup build artifacts
clean:
	rm main.vcd main.fs

.PHONY: load clean test
.INTERMEDIATE: main_pnr.json main.json
