# Wildfires

The wildfires dataset (wildfires.csv) describes 350 wildfires that started within a large national park. 17 variables are documented for each fire. For task 1, the outcome variable is burned, and we will be using all other variables except for wlf as predictors. For task 2, the outcome variable is wlf, and we will be using the remaining 16 variables as predictors. 

![image](https://cloud.githubusercontent.com/assets/22163404/20635419/6620e40e-b322-11e6-8369-7de450ea5386.png)


The origin of each fire is shown below in red.

<img width="354" alt="wildfires_visual" src="https://cloud.githubusercontent.com/assets/22163404/20633797/e30bc604-b30f-11e6-851e-f7764c27c503.PNG">

A number of factors may affect how large a fire becomes. For example, if it starts near a ranger station (green
triangles on the map) at a time when it is manned, fires may be less likely to spread.
Your job is to make two types of predictions. First, you must predict how large a fire will be. In the context
of the data, you will be using all of the variables (except ‘wlf’) to predict the ‘burned’ column.
Second, you will need to predict whether a fire will spread to a wildlife protection zone denoted by the light
green triangle in the northeastern section of the park. In other words, use all of the columns (except ‘burned’)
to predict the ‘wlf’ column.

Task 1: Area Burned

We utilized the best subset selection approach with the given data in order to predict the area burned by the fire. By using the best subset selection, we were able to get the best model for each subset size and proceed to pick out the number of predictor variable that were optimal in adjusted R squared, Cp, and BIC. The computational limitations of using the best subset selection were not a problem in this case since the data only consisted of 17 variables. The regsubsets() function allows us to identify the best model (in terms of RSS) that contains a certain number of predictors. The resulting asterisks indicate that the given variable is included in the corresponding model.


Given this information, we plotted the RSS, adjusted R squared, Cp, and BIC for all of the models in order to determine how many variables to include in the optimal model. Each statistic gave us a different answer:




Taking this into consideration, we also used cross-validation to see what the optimal number of variables to include in the model would be as well as which variables those should be. To do this, we separate our training data into 10 folds and then look at the test MSE for a model with j variables averaged across each fold. Cross validation tells us that we should use a 6 variable model, which is also the same number of variables that the BIC statistic recommended using. 


We decided to include 6 variables in the model to predict the burned variable because both cross-validation and BIC suggested including 6 variables. In addition, because the variability of the prediction greatly increases as the number of predictor variables increases, we judged that the tradeoff between the decrease in bias and increase in variability did not justify using large number of variables. As can be seen from the plotted adjusted R squared, CP and BIC, increasing the number of variable does not influence the adjusted R squared, CP and BIC to fluctuate greatly  in value after a certain point. To determine which 6 variables to include, we performed best subset selection on the training data set and determined that the variables temp, days, vulnerable, other, ranger, and resources should be included in the model.


FINAL MODEL:

burned = -1169.2008058 + 0.9902074*temp + 9.1998664*days + 0.7573446*vulnerable + 207.3914835*other - 30.6768847*ranger - 1.9275657*resources

Task 2: Wildlife Protection
