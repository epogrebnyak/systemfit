Klein Model I
=============

systemfit 
<https://cran.r-project.org/web/packages/systemfit/systemfit.pdf>
page 18

<https://cran.r-project.org/web/packages/systemfit/vignettes/systemfit.pdf>
Klein’s model I

<https://vincentarelbundock.github.io/Rdatasets/doc/sem/Klein.html>

Original publication:
<http://cowles.yale.edu/sites/default/files/files/pub/mon/m11-all.pdf>

<http://economics.sas.upenn.edu/sites/economics.sas.upenn.edu/files/u4/Visco_Klein_2014.pdf>


```
Table F10.3: Klein’s Model I , 22 Yearly Observations, 1920-1941 
Source: Klein (1950) Model I
Year = Date,
C = Consumption,
P = Corporate profits,
Wp = Private wage bill,
I = Investment,
K1 = previous year’s capital stock,
X = GNP,
Wg = Government wage bill,
G = Government spending,
T = Taxes

Еxplainations: 
http://cowles.yale.edu/sites/default/files/files/pub/mon/m11-all.pdf
стр. 

Year  C     P   Wp   I    K1    X   Wg    G    T   
1920 39.8 12.7 28.8  2.7 180.1 44.9 2.2  2.4  3.4
1921 41.9 12.4 25.5 -0.2 182.8 45.6 2.7  3.9  7.7
1922 45.0 16.9 29.3  1.9 182.6 50.1 2.9  3.2  3.9
1923 49.2 18.4 34.1  5.2 184.5 57.2 2.9  2.8  4.7
1924 50.6 19.4 33.9  3.0 189.7 57.1 3.1  3.5  3.8
1925 52.6 20.1 35.4  5.1 192.7 61.0 3.2  3.3  5.5
1926 55.1 19.6 37.4  5.6 197.8 64.0 3.3  3.3  7.0
1927 56.2 19.8 37.9  4.2 203.4 64.4 3.6  4.0  6.7
1928 57.3 21.1 39.2  3.0 207.6 64.5 3.7  4.2  4.2
1929 57.8 21.7 41.3  5.1 210.6 67.0 4.0  4.1  4.0
1930 55.0 15.6 37.9  1.0 215.7 61.2 4.2  5.2  7.7
1931 50.9 11.4 34.5 -3.4 216.7 53.4 4.8  5.9  7.5
1932 45.6  7.0 29.0 -6.2 213.3 44.3 5.3  4.9  8.3
1933 46.5 11.2 28.5 -5.1 207.1 45.1 5.6  3.7  5.4
1934 48.7 12.3 30.6 -3.0 202.0 49.7 6.0  4.0  6.8
1935 51.3 14.0 33.2 -1.3 199.0 54.4 6.1  4.4  7.2
1936 57.7 17.6 36.8  2.1 197.7 62.7 7.4  2.9  8.3
1937 58.7 17.3 41.0  2.0 199.8 65.0 6.7  4.3  6.7
1938 57.5 15.3 38.2 -1.9 201.8 60.9 7.7  5.3  7.4
1939 61.6 19.0 41.6  1.3 199.9 69.5 7.8  6.6  8.9
1940 65.0 21.1 45.0  3.3 201.2 75.7 8.0  7.4  9.6
1941 69.7 23.5 53.3  4.9 204.5 88.4 8.5 13.8 11.6
```

##In gretl 

<http://gretl.sourceforge.net/gretl-help/scripts/klein.inp>

```gretl

# Replication of "Model 1" from L. Klein, "Economic 
# Fluctuations in the United States, 1921-1941", 
# New York: John Wiley and Sons, 1950.

open klein.gdt

genr W = Wp + Wg
genr A = t + (1918 - 1931)
genr K1 = K(-1)

# set the model up as a system
"Klein Model 1" <- system
 equation C 0 P P(-1) W 
 equation I 0 P P(-1) K1
 equation Wp 0 X X(-1) A
 identity P = X - T - Wp
 identity W = Wp + Wg
 identity X = C + I + G
 identity K = K1 + I
 endog C I Wp P W X K
end system

# and estimate it in various ways
estimate "Klein Model 1" method=ols
estimate "Klein Model 1" method=tsls
estimate "Klein Model 1" method=3sls
estimate "Klein Model 1" method=fiml --verbose
estimate "Klein Model 1" method=liml
```
