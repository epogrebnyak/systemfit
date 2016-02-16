#data( 'KleinI' , package = 'AER')

csv_doc = ",Year,C,P,Wp,I,K.lag,X,Wg,G,T
1,1920,39.8,12.7,28.8,2.7,180.1,44.9,2.2,2.4,3.4
2,1921,41.9,12.4,25.5,-0.2,182.8,45.6,2.7,3.9,7.7
3,1922,45,16.9,29.3,1.9,182.6,50.1,2.9,3.2,3.9
4,1923,49.2,18.4,34.1,5.2,184.5,57.2,2.9,2.8,4.7
5,1924,50.6,19.4,33.9,3,189.7,57.1,3.1,3.5,3.8
6,1925,52.6,20.1,35.4,5.1,192.7,61,3.2,3.3,5.5
7,1926,55.1,19.6,37.4,5.6,197.8,64,3.3,3.3,7
8,1927,56.2,19.8,37.9,4.2,203.4,64.4,3.6,4,6.7
9,1928,57.3,21.1,39.2,3,207.6,64.5,3.7,4.2,4.2
10,1929,57.8,21.7,41.3,5.1,210.6,67,4,4.1,4
11,1930,55,15.6,37.9,1,215.7,61.2,4.2,5.2,7.7
12,1931,50.9,11.4,34.5,-3.4,216.7,53.4,4.8,5.9,7.5
13,1932,45.6,7,29,-6.2,213.3,44.3,5.3,4.9,8.3
14,1933,46.5,11.2,28.5,-5.1,207.1,45.1,5.6,3.7,5.4
15,1934,48.7,12.3,30.6,-3,202,49.7,6,4,6.8
16,1935,51.3,14,33.2,-1.3,199,54.4,6.1,4.4,7.2
17,1936,57.7,17.6,36.8,2.1,197.7,62.7,7.4,2.9,8.3
18,1937,58.7,17.3,41,2,199.8,65,6.7,4.3,6.7
19,1938,57.5,15.3,38.2,-1.9,201.8,60.9,7.7,5.3,7.4
20,1939,61.6,19,41.6,1.3,199.9,69.5,7.8,6.6,8.9
21,1940,65,21.1,45,3.3,201.2,75.7,8,7.4,9.6
22,1941,69.7,23.5,53.3,4.9,204.5,88.4,8.5,13.8,11.6"

kd <- read.csv(con <- textConnection(csv_doc), header=TRUE, row.names = 1)
close(con)

#csv_doc = ",Year,C,P,Wp,I,K.lag,X,Wg,G,T
#C = Consumption,
#P = Corporate profits,
#Wp = Private wage bill,
#I = Investment,
#K1 = previous year’s capital stock,
#X = GNP,
#Wg = Government wage bill,
#G = Government spending,
#T = Taxes

consump   = kd$C
corpProf  = kd$P
corpProfLag = lag(kd$P)
wages = kd$Wp + kd$Wg

R> eqConsump <- consump ~ corpProf + corpProfLag + wages
R> eqInvest <- invest ~ corpProf + corpProfLag + capitalLag
R> eqPrivWage <- privWage ~ gnp + gnpLag + trend
R> inst <- ~ govExp + taxes + govWage + trend + capitalLag + corpProfLag + gnpLag




eqConsump <- consump ~ corpProf + corpProfLag + wages
eqInvest <- invest ~ corpProf + corpProfLag + capitalLag
eqPrivWage <- privWage ~ gnp + gnpLag + trend
inst <- ~ govExp + taxes + govWage + trend + capitalLag + corpProfLag + gnpLag
system <- list( Consumption = eqConsump, Investment = eqInvest, PrivateWages = eqPrivWage )

# OLS estimation:
kleinOls <- systemfit( system, data = KleinI )
round( coef( summary( kleinOls ) ), digits = 3 )

# 2SLS estimation:
klein2sls <- systemfit( system, method = "2SLS", inst = inst, data = KleinI,
+ methodResidCov = "noDfCor" )
round( coef( summary( klein2sls ) ), digits = 3 )

# 3SLS estimation:
klein3sls <- systemfit( system, method = "3SLS", inst = inst, data = KleinI, methodResidCov = "noDfCor" )
round( coef( summary( klein3sls ) ), digits = 3 )

# iterated 3SLS estimation:
kleinI3sls <- systemfit( system, method = "3SLS", inst = inst, data = KleinI, methodResidCov = "noDfCor", maxit = 500 )
round( coef( summary( kleinI3sls ) ), digits = 3 )
