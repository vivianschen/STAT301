# Wildfires

The wildfires dataset (wildfires.csv) describes 350 wildfires that started within a large national park. 17 variables are documented for each fire. For task 1, the outcome variable is burned, and we will be using all other variables except for wlf as predictors. For task 2, the outcome variable is wlf, and we will be using the remaining 16 variables as predictors. 

![image](https://cloud.githubusercontent.com/assets/22163404/20635461/eedf8dea-b322-11e6-8458-45e7d1fc8f98.png)


The origin of each fire is shown below in red.

<img width="354" alt="wildfires_visual" src="https://cloud.githubusercontent.com/assets/22163404/20633797/e30bc604-b30f-11e6-851e-f7764c27c503.PNG">

A number of factors may affect how large a fire becomes. For example, if it starts near a ranger station (green
triangles on the map) at a time when it is manned, fires may be less likely to spread.
Your job is to make two types of predictions. First, you must predict how large a fire will be. In the context
of the data, you will be using all of the variables (except ‘wlf’) to predict the ‘burned’ column.
Second, you will need to predict whether a fire will spread to a wildlife protection zone denoted by the light
green triangle in the northeastern section of the park. In other words, use all of the columns (except ‘burned’)
to predict the ‘wlf’ column.


**TASK 1: Area Burned**

We utilized the best subset selection approach with the given data in order to predict the area burned by the fire. By using the best subset selection, we were able to get the best model for each subset size and proceed to pick out the number of predictor variable that were optimal in adjusted R squared, Cp, and BIC. The computational limitations of using the best subset selection were not a problem in this case since the data only consisted of 17 variables. The regsubsets() function allows us to identify the best model (in terms of RSS) that contains a certain number of predictors. The resulting asterisks indicate that the given variable is included in the corresponding model.


Given this information, we plotted the RSS, adjusted R squared, Cp, and BIC for all of the models in order to determine how many variables to include in the optimal model. Each statistic gave us a different answer:

![image](https://cloud.githubusercontent.com/assets/22163404/20635510/7fee12e8-b323-11e6-866c-c7343509af79.png)

![image](https://cloud.githubusercontent.com/assets/22163404/20635519/959bcbee-b323-11e6-9a83-9cde792f8315.png)



Taking this into consideration, we also used cross-validation to see what the optimal number of variables to include in the model would be as well as which variables those should be. To do this, we separate our training data into 10 folds and then look at the test MSE for a model with j variables averaged across each fold. Cross validation tells us that we should use a 6 variable model, which is also the same number of variables that the BIC statistic recommended using. 


We decided to include 6 variables in the model to predict the burned variable because both cross-validation and BIC suggested including 6 variables. In addition, because the variability of the prediction greatly increases as the number of predictor variables increases, we judged that the tradeoff between the decrease in bias and increase in variability did not justify using large number of variables. As can be seen from the plotted adjusted R squared, CP and BIC, increasing the number of variable does not influence the adjusted R squared, CP and BIC to fluctuate greatly  in value after a certain point. To determine which 6 variables to include, we performed best subset selection on the training data set and determined that the variables temp, days, vulnerable, other, ranger, and resources should be included in the model.


**Conclusion**

With 6 predictors, our final model using linear regression is: 

burned = -1169.2008058 + 0.9902074*temp + 9.1998664*days + 0.7573446*vulnerable + 207.3914835*other - 30.6768847*ranger - 1.9275657*resources


**TASK 2: Wildlife Protection**


We utilized the lasso approach in order to predict whether or not a wildfire will spread into the wildlife protection zone. Unlike for task 1 which was to predict a quantitative response variable, using linear model has clear limitation with classification problems such as task 2. When thinking intuitively about the dataset, we have reason to believe that some variables in the dataset will not be correlated with whether or not a wildfire will spread into a wildlife protection zone, whereas in task 1, all variables in the dataset seemed to have some correlation with the area burned by a wildfire. For example, it is reasonable to think that the wind speed may be relevant to whether or not a wildfire will spread into the wildlife protection zone because a higher wind speed can affect how far and how quickly a fire can spread. On the other hand, the number of days since the last fire does not seem as relevant to how likely a wildfire will spread into that certain area. Therefore, we decided to use the lasso approach so that the model would shrink the coefficients closer to zero while also using selection by setting less relevant variables to zero as to exclude the less important predictors. With the lasso method, the key to minimizing the test error is finding the tuning parameter lambda that gives the least mean squared error. Instead of using the default grid that the cv.glmnet function inherently has, we set up the grid to range from 10 to 1.0000e^(-5) after realizing that the optimal lambda is extremely small. As can be seen in the following graph, lambda that returns least MSE is approximately 0.0045.

![image](https://cloud.githubusercontent.com/assets/22163404/20635542/f00f06e0-b323-11e6-8648-fae9cb5ed259.png)


**Conclusion**

We believe the most appropriate model for task 2 is the predict function using lasso with the tuning parameter lambda value of approximately 0.0045. Out of all the variables, x, humidity, rain, vulnerable, trafficmed, and burned are shrunk to zero. Following are the coefficients that are shrunk according to lasso regularization.

The final model is thus:

wlf = 0.1761275775 + 0*x - 0.0005137748*y + 0.0036493706*temp + 0*humidity + 0.0521648730*windspd - 0.1199334325*winddirN - 0.0679614431*winddirNE - 0.2210687526*winddirNW - 0.4234247046*winddirS - 0.1500101449*winddirSE - 0.3270872432*winddirSW - 0.3442694273*winddirW + 0*rain - 0.0007658695*days + 0*vulnerable + 0.0490929418*other - 0.1141558689*ranger + 0.0141028946*pre1950 - 0.0095928748*heli - 0.0012045390*resources - 0.1027864843*trafficlo + 0*trafficmed + 0*burned
