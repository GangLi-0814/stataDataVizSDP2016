// Load the performance data
msas using msas.xlsx, perf

// Fit regression model to data w/interaction term
reg gradrate i.region##c.rlagro if schnm != "District Level"

// Estimate the marginal effects for every 5 point change in reading growth
margins region, at(rlagro=(0(5)100))

// Create a graph with default settings
marginsplot

// Export the plain/default example
gr export exampleGraphs/marginsplotExample1.pdf, as(pdf) replace

// Make slight improvement
marginsplot, by(region) recastci(rarea) recast(line)

// Export the plain/default example
gr export exampleGraphs/marginsplotExample2.pdf, as(pdf) replace

// Use a custom scheme to clean things up a bit
marginsplot, by(region) recastci(rarea) recast(line) scheme(sdp2016a2)

// Export the graph to be included elsewhere
gr export exampleGraphs/marginsplot2016a2.pdf, as(pdf) replace

// Use a custom scheme to clean things up a bit
marginsplot, by(region) recastci(rarea) recast(line) scheme(sdp2016b2)

// Export the graph to be included elsewhere
gr export exampleGraphs/marginsplot2016b2.pdf, as(pdf) replace

// The same method is also helpful for visualizing nonlinear relationships
reg gradrate c.rlagrol##c.rlagrol if schnm != "District Level"

// Estimate the marginal effect of gains in points for reading growth for the low 25% on grad rates
margins, at(rlagrol=(0(5)100))

// Simple plot of the marginal effects
marginsplot

// Export the plain/default example
gr export exampleGraphs/marginsplotPolynomial1.pdf, as(pdf) replace

// You can adjust how the graph is rendered as well
marginsplot, recast(line)

// Export the plain/default example
gr export exampleGraphs/marginsplotPolynomial2.pdf, as(pdf) replace

// You can adjust how the graph is rendered as well
marginsplot, recast(line) recastci(rarea) scheme(sdp2016a)

// Export the plain/default example
gr export exampleGraphs/marginsplotPolynomial3.pdf, as(pdf) replace

// Set the location where the example data will be loaded from
webuse set http://www.stata-press.com/data/ivrm/

// Load example dataset for multilevel marginal effects
webuse school_read.dta, clear

// Fit multilevel model with categorical level 2 variable
_eststo m1: mixed read i.schtype##c.ses || schoolid: schtype, cov(uns)

// Estimate marginal effects of school type
margins schtype, at(ses=(20(5)80))

// Graph the results
marginsplot, noci scheme(sdp2016b)

// Export the plain/default example
gr export exampleGraphs/marginsplotLevel2a.pdf, as(pdf) replace

// Replays the estimation results from the previous model to avoid an error
est replay m1

// Estimates the marginal effects of school type with specified values of ses
margins r.schtype, at(ses=(20(5)80)) contrast(effects)

// Graphs the marginal effects
marginsplot, noci scheme(sdp2016b2) yline(0) xline(45) xline(52) 

// Export the plain/default example
gr export exampleGraphs/marginsplotLevel2b.pdf, as(pdf) replace

// Load other example data set
webuse school_math.dta, clear

// Defines value labels
la def female 0 "Male" 1 "Female"

// Applies value labels
la val female female

// Fit a multilevel model where the level 2 variable is continuous
mixed math i.female##c.clsize || schoolid: clsize, cov(uns) 

// Estimate marginal effects of sex at varying class sizes
margins female, at(clsize=(10(2)50))

// Graph the marginal effects
marginsplot, recast(line) recastci(rarea) scheme(sdp2016a2) 

// Export the plain/default example
gr export exampleGraphs/marginsplotLevel2c.pdf, as(pdf) replace

