# Wildfires

The wildfires dataset (wildfires.csv) describes 350 wildfires that started within a large national park. 17 variables are documented for each fire. For task 1, the outcome variable is burned, and we will be using all other variables except for wlf as predictors. For task 2, the outcome variable is wlf, and we will be using the remaining 16 variables as predictors. 

The origin of each fire is shown below in red.

<img width="354" alt="wildfires_visual" src="https://cloud.githubusercontent.com/assets/22163404/20633797/e30bc604-b30f-11e6-851e-f7764c27c503.PNG">

A number of factors may affect how large a fire becomes. For example, if it starts near a ranger station (green
triangles on the map) at a time when it is manned, fires may be less likely to spread.
Your job is to make two types of predictions. First, you must predict how large a fire will be. In the context
of the data, you will be using all of the variables (except ‘wlf’) to predict the ‘burned’ column.
Second, you will need to predict whether a fire will spread to a wildlife protection zone denoted by the light
green triangle in the northeastern section of the park. In other words, use all of the columns (except ‘burned’)
to predict the ‘wlf’ column.
Both prediction tasks are detailed in the next two sections, followed by a description of the dataset.

Task 1: Area Burned

Task 2: Wildlife Protection
