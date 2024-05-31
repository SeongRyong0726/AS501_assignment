
# Makefile Macros
RUN = rtl

REPORT_NAME = test_report.hud

VCS_INCLUDE = -f ./tb_${RUN}.f

VCS_OPT = \
		-full64 \
		-licqueue \
		-quiet \
		-debug_access+all \
		-reportstats \
		+memcbk \
		+v2k \
		-sverilog \
		+warn=noTFIPC \
		+lint=TFIPC-L \
		+nospecify \
		+error+50 \
		+vcs+initreg+random \
		-o simv \
		+define+LOOPBACK_EXT \
		+define+LOOPBACK_CLUSTER \
		+define+LOOPBACK_FGMEM \
		+define+LOOPBACK_PREPROCESS \
		+define+CMEM_PREPROCESS \
		+define+INST_CLUSTER \
		+define+INST_FGMEM \
		+define+INST_PREPROCESS \
		+define+CMEM_FGMEM 


ifeq ($(RUN), rtl) 
	VCS_OPT += 	+notimingcheck
else ifeq ($(RUN), syn)
	VCS_OPT +=	+notimingcheck \
				+neg_tchk	\
				+define+GATE_SIM \
				+define+SYNTHESIS 
else
	VCS_OPT = VCS_OPT
endif

VCS_VERDI = -kdb #-cm line+tgl+fsm+branch+cond+assert	# Coverage Test
VCS_LOG = | tee -i ./vcs_${RUN}.log

SIMV_OPT = -reportstats +fsdb+delta
SIMV_VERDI = #-cm line+tgl+fsm+branch+cond+assert		# Coverage Test
SIMV_LOG = -l ./simv.log
SIMV_OPT += +vcs+initreg+random

VERDI_INCLUDE = $(VCS_INCLUDE)
VERDI_FSDB = -ssf ./fsdb_${RUN}.fsdb
VERDI_COV_INCLUDE = ./simv.vdb/


all: clean compile run verdi
upd: compile run

# VCS
compile:
	@echo ""
	@echo "**********************************"
	@echo "Compiling Design:" $(RUN)
	@echo "**********************************"
	@echo ""

	vcs $(VCS_INCLUDE) $(VCS_OPT) $(VCS_VERDI) $(VCS_LOG) 
	
	@echo ""
	@echo "**********************************"
	@echo "Compiled Design:" $(RUN)
	@echo "**********************************"
	@echo ""	
	
run:
	@echo ""
	@echo "**********************************"
	@echo "Running Simulation:" $(RUN)
	@echo "**********************************"
	@echo ""
	
	./simv  $(SIMV_OPT) $(SIMV_VERDI) $(SIMV_LOG)
	
	@echo ""
	@echo "**********************************"
	@echo "Done Simulation:" $(RUN)
	@echo "**********************************"
	@echo ""

# Verdi
verdi:
	@echo ""
	@echo "**********************************"
	@echo "Debugging for:" $(RUN)
	@echo "**********************************"
	@echo ""
	Verdi-Ultra $(VERDI_INCLUDE) $(VERDI_FSDB) &

cov:
	@echo ""
	@echo "**********************************"
	@echo "Debugging for:" $(RUN)
	@echo "**********************************"
	@echo ""
	Verdi-Ultra -cov -covdir $(VERDI_COV_INCLUDE) -plan plans/verification_plan.hvp -userdata *.hud &


# Helpers
clean:
	rm -rf DVEfiles csrc simv simv.daidir ucli.key \
			vcdplus_rtl.vpd simv.pdaidir vcdplus_syn.vpd out/*
	rm -rf *.fsdb novas.rc novas_dump.log novas.conf cm.log verdiLog simv.vdb *.log vdCovLog verdi_config_file \
			Verdi-UltraLog *.hud urgReport .fsm.sch*

help:
	@echo ""
	@echo "Makefile Usage: "
	@echo ""
	@echo "	make compile RUN=rtl for Running vcs for RTL Simulation"
	@echo ""
	@echo "Makefile Simultion Options"
	@echo "**************************"
	@echo "compile"
	@echo "	Runs VCS and generates simv"
	@echo "run"
	@echo "	Executes simv only (no re-compilation w/ VCS)"
	@echo "verdi"		
	@echo "	Runs Verdi-Ultra with src file identical to simulation"
	@echo "cov"
	@echo "	Runs Verdi-Coverage (for code coverage & Test Planner)"
	@echo ""
