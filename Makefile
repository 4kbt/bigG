OCT:= octave -p mlib


PLOTINPUTS:= results/BootstrapResult.dat results/BirgeRatioedTraditionalAverage.dat results/BootstrapHistogram.dat
CODATA:= CODATABootstrapComparison


all : $(CODATA).eps 

$(PLOTINPUTS) : bigGBootstrap.m codata.dat mlib/*
	$(OCT) bigGBootstrap.m

plots/$(CODATA).eps: $(CODATA).gpl $(PLOTINPUTS) RawData/codata.dat RawData/CODATA2010Recommendation.dat
	gnuplot $(CODATA).gpl
