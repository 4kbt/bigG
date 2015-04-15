clear 

d = load('codata.dat');

%Debugging line for Birge-ratio check
%d(:,5) = d(:,5)*4.37;

NBootstraps = 10000;

%initialize bootstrap-result vector
bO =[];

%start bootstrapping
for ( i = 1:NBootstraps )

	b = bootstrapData(d);

	%Inefficient but trusted error calculation
	meanAndStdDev = uncertaintyOverTime( b(:,4), b(:,5) )(end,:);

	%X^2
	X2 = sum ( ( b(:,4) - meanAndStdDev(:,1) ) .^2 ./ b(:,5).^2 );

	%save bootstrap results
	bO = [bO; meanAndStdDev X2];

end

%compute bootstrapped mean and standard deviation of G
GMean = mean( bO(:,1) );
GStd  = std(  bO(:,1) );

%Make a histogram
hist( bO(:,1) , sqrt(NBootstraps));


'Stephan cross-check'
lsa_mean = sum( d(:,4) ./ ( d(:,5).^2 ) ) / sum( 1.0 ./ d(:,5).^2 )
lsa_sig =                       sqrt( 1.0 / sum( 1.0 ./ d(:,5).^2 ) )

lsa_X2 = sum ( ( d(:,4) - lsa_mean ) .^2 ./ d(:,5).^2 )

lsa_birge_ratio = sqrt(lsa_X2/rows(d))

'lsa error in ppm'
lsa_sig / lsa_mean * 1e6

'adj. lsa error in ppm'
lsa_sig * lsa_birge_ratio / lsa_mean * 1e6



'Charlie cross-check'
OrigMean = uncertaintyOverTime( d(:,4), d(:,5) )(end,:)

'Bootstrapped result'
[GMean GStd]

'Bootstrapped relative uncertainty, ppm'
GStd/GMean * 1e6

'Bootstrapped X^2'
mean( bO(:,3) )
