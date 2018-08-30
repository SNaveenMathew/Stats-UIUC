######################################################################################
# INTRODUCTION TO RSTUDIO - A TUTORIAL
# Modified from original tutorial by Dario Fanucchi - May 2012
######################################################################################

# If you are not reading this file from within RStudio, you can open it in RStudio in
# one of several ways:
# - Open the file using "File"->"Open File" in the RStudio editor
# - At the terminal/cmd write the following:
#   rstudio Rstudio_intro.r
# - In RStudio in the files window (bottom right of the screen or ctrl+5 to activate), browse
#   to the location of the file by clicking the "..." to the top-right of the window, and
#   then open the directory. Click on the file in the files window and it will load in the editor.


######################################################################################
# 1. Using RStudio to run line-by-line from scripts
######################################################################################
# In RStudio you can execute commands line by line or in the console. 
# Copy the following command (without the "#") into the console and press enter:
# plot(c(1,2,3,4,5), c(1,2,3,4,5))
# you'll notice that a plot appears in the plots window as a result of the command.
# Instead of typing directly in the console you can type the command in a .r script
# like this one and run it in the console. 

# Place your cursor on the line below and press "Control+Enter" or "Cmd+Enter"
plot(c(1,2,3,4,5), c(1,2,3,4,5), "l")

# Notice how a plot appears in the plot window corresponding to this command. 
# Don't worry about exactly how the plot command works yet. It will be covered in
# later tutorials

# Anything that you run from a script using "Control+Enter" gets typed directly in the 
# R console. You can equivalently copy everything out in the console and it will
# work fine, but it is generally easier to work in the editor and use "Control+Enter" to
# execute commands in the console.

######################################################################################
# 2. Variables, the Workspace, and basic arithmetic
######################################################################################

# In R you can assign a value to a variable by using the "<-" operator.
# Run the following line of code by pressing "Control+Enter"
x <- 10
# Make sure the Workspace window is visible by typing "Control+3". 
# Notice that the  Workspace window now contains a variable x, with a value of 10.
# You can edit x in the workspace window by clicking on x and typing a new value.
# Try changing the value of x to 15. Then run the following line (with control+Enter) 
# to print it in the console.
x
# To remove x from the workspace use the "remove" function:
remove(x)
# Notice how x no longer shows up in the Workspace window.
# Typing x now produces an error:
x  # will produce an error: object 'x' not found!

# R can be used to perform arithmetic in a similar fashion to a calculator. For instance,

# you can type this:
(1242-241.1)*32.21

# When you press control+Enter, the cursor automatically moves to the next line in the console
# This way, you can run scripts one line at a time by repeatedly pressing control+enter
# The following code does some basic arithmetic.  

# Run it line by line

x <- 2                 # ask someone to guess a number between 1 and 10
y <- x*9               # tell them to multiply it by 9
d1 <- floor(y/10)      # get the first digit  (floor(x) gives the integer part of x)
d2 <- y%%10            # get the second digit (a%%b gives the remainder when a is divided by b)
d1+d2-4                # tell them to add the digits and subtract 4: they are left with the number 5!

# The code above performed an old classic arithmetic "teaser". Starting with any number (x)
# Multiply it by 9, add the digits of the result, subtract 4 and your answer will always be 5.
# Try changing the initial value of x to some other number between 1 and 10 and see if it works.
# Notice how it is possible to add comments next to code to explain what it does. This is generally
# good practice in any programming language. 

# Notice how as you ran the code lines above, the variables d1, d, x and y were added to the workspace with their values
# You can see in the workspace that d1 and d2 are indeed the first and second digit of y respectively.
# Since we're done with these variables, we'll keep our workspace clean by removing them:
remove(x,y,d1,d2)


######################################################################################
# 3. Running sections of a script
######################################################################################

# Before we begin this next section, you may want to clear your console so that things are
# less cluttered. Simply type "Control+L" and the console will be cleared. The cursor will also
# switch to the console. If you wish to view your previous commands, you can still place 
# the cursor in the console and press the up arrow to see them. 
# You can press Control+up arrow (with your cursor in the console) to see your command history 
# in a pop-up window. The workspace windows' History tab also shows your command history. 
#Highlighting any command  and clicking 'To Console' ir 'To Source' copies it over to the 
# appropriate window.If you don't want to reach for a mouse, you can switch back to the editor
# from the console with "Control+1"

# Sometimes you don't want to run your code line-by-line but rather in a batch.
# In RStudio you can simply highlight the code you want to run and press "Control+Enter"
# just as before to run all the code you highlighted.

# The code below computes the prime numbers in the range 1-100 and writes them in the console.
# There are many control structures and commands in this code, and it might
# feel excessive to run it line-by line. Don't worry about how it works for the moment 
# (although there are line-by-line comments for the very enthusiastic reader)
# In order to run it all in one shot, highlight the whole section and press "Control+Enter"

x <- lapply(1:100, function(x)TRUE)              # make a vector of 100 elements all equal to TRUE
prim <- NULL                                     # Empty list of currently known primes
x[1] <- FALSE                                    # 1 is not a prime number
for(i in 2:100){                                 # go through the list from 2 to 100 
  if(x[i]==TRUE) {                               # if i is known to be prime...
    prim <- append(prim, i)                      #    ... add it to the list of known primes
    if(i<=50)                                    #    ... if i has multiples in [1,100] ...
      for(j in i*(2:(100/i))  ) x[j]=FALSE       #         ... and set all multiples of i to be NOT prime
  }
}
print(prim)                                      # print the list of discovered primes to the console

# Notice that all the code gets "typed" into the console when you press Control+Enter. The list of 
# primes below 100 is produced. 


######################################################################################
# 3. Vectors/Lists in R
######################################################################################

# Look at your workspace (Ctrl+3 if it isn't showing). There are two variables i and j that are single 
# valued variables similar to those we've seen before. i has a value of 100L. The L just refers to 
# the data type associated with i: in this case it is a "long integer". You can edit its value by 
# clicking on it, just as we did with x earlier. You can also edit the value of j.
# There are also two other variables in your workspace that are not as familiar: x and prim.
# These are lists. 
# Next to prim is a summary of the structure of the data it contains: integer[25].
# this says that prim is a list containing 25 integers. 
# Click on prim in the workspace.
# A window opens up with the contents of the list. It is preceeded by the letter "c". This is how
# lists are represented in R. 
# Indeed we can make a new list by using the "c" (concatenate) command:
mylist <- c(1.1, 2.2, 3.3, 4.4, 5.5, 4.4, 3.3, 2.2, 1.1)

# You can click on mylist in the workspace to see (and edit) its contents. Notice that it is summarized as
# numeric[9]. It contains 9 elements, each of which is a numeric data type. Data in R is numeric
# by default, but we can switch between data types by using "as.integer" and "as.numeric":

myinteger <- as.integer(2.3)           # gets rounded down to 2
myintlist <- as.integer(mylist)        # look at the result in the workspace to see how rounding off took place
numprimes <- as.numeric(prim)          # convert the "integers" in prim to a numeric list
xlog      <- as.logical(x)             # convert the general data (list) to TRUE/FALSE data (logical)

# You can edit these in the console by clicking on them and editing the values. Notice that if you delete
# the "c" or the opening/closing brackets or otherwise turn the data into an illegal R statement,
# an error will be reported in the console and the variable will be unchanged.

# Notice that you can change the type of data by editing it. For instance, change the first 
# element in xlog to 2. When you save the result, it will change xlog to a "numeric" list 
# where TRUE->1 and FALSE->0. The introduction to R tutorials provide more information on how
# to use c()

# We now have quite a few variables hanging around in the workspace.
# Clean up the entire workspace by clicking the "Clear All" button or typing the following code:
remove(list=ls())                    

######################################################################################
# 5. Some RStudio-specific tips and tricks
######################################################################################

# Using code completion and Help
# ==============================

# Code Completion is an extremely useful feature that has been very well implemented
# in RStudio. If you begin typing the name of some function, you can get RStudio to complete
# it for you (or provide a list of possible completions) by simply hitting the TAB key at the
# end of the line so far. If several completions are possible, they are displayed in a list
# below the cursor. Hitting TAB twice will automatically complete using the first option available.
# For example, try completing some of the following phrases by hitting TAB 
# (see wat options you have):
plo
do.
len
strs
med
# Autocompletion works both in the source editor and in the console. 

# Notice how the autocompletion also gives you a bit more information about the functions.
# If you need still further information, you can make use of the Help option: Press F1 while
# hovering over a valid R function or command. For example, try the completion of the last
# statement above: 
# Press F1 over the line of code below or Code->Go to help
median
# Notice that the help window (my bottom right corner) loads the help for "Median Value".
# This feature is very useful indeed, and it can increase your productivity in R substantially
# to be able to obtain help very quickly on functions you wish to use in this fashion.

# Console History and History tab
# ===============================

# As previously mentioned it is possible to obtain previous statements typed into the
# console by pressing the up arrow when inside the console.
# If you would like a bit more control over your previous statements, you can open the
# History window.
# The History window can be activated by typing Ctrl+4, or by clicking on the History tab
# to the left. Inside the History window, you can scroll through all code previously run
# in the console.
# Double clicking an entry in the History window (or clicking Enter on it) 
# will cause it to copy to the console, where it can be evaluated. 
# Alternatively, you can click the "To Source" button (or type Shift+Enter) 
# to send the highlighted line(s) to the current location in the source editor. 

#As an example, run the following lines of code:
x <- 1
y <- 1


# and now run the following block of code
x <- x*(x%%2+1)+1
y <- y*(x+1)

# Place the cursor in the source below this comment, then look in the history window
# for the above two lines, highlight them and click Shift+Enter. Observe how the lines
# get copied below. You can type this several times to generate several copies. You can
# then use Ctrl+1 to get back to the source editor and run the code. Alternatively you could
# send the code directly to the console from the History. Try both.

# ^ ^ ^ Place cursor above this line when inserting from history ^ ^ ^ 

# Including Packages
# ==================
# To load an already-installed package, you can go to the packages tab (ctrl+7), and
# select the package that you want to use. For instance, you can include the Matrix 
# package in this fashion. You can also do this in code as follows:
library("Matrix")

# once you've included a package, you can make use of functions from that package. You can
# click the name of a package in your Packages window to get help for that specific package.
# Here are some examples using the Matrix package
M <- Matrix(0, 2, 2, sparse=FALSE)
M[1,1] = 2; M[1,2] = 3
M[2,1] = 3; M[2,2] = 4;
M
det(M)

# Other Features to keep in mind
# =========================================
# After working through this tutorial you should be fairly comfortable and productive at
# using RStudio for editing your R code. There are, however, further features that could
# be useful to you in your work, but that we will not cover in depth in this tutorial. 
# Below is a list of some of these:

# - You can install new packages and update existing packages in the "Packages" tab.
# - The "Help" tab can be very useful for navigating the help of various packages.
#   You are strongly encouraged to use it extensively.
# - RStudio is fully compatible with Version Control. This can be invaluable when developing 
# large collaborative projects in R. If you need more information about using SVN and R, 
# ask the mentors!
# - Standard editing tricks like commenting/uncommenting code (Ctrl+/), indentation (ctrl+I), 
# searching code, replacing text, etc. are also available in RStudio
# - Projects! 
#   You can create R Projects in RStudio, where several files and functions share a workspace and 
#   a working directory. This is the neat way to work on large pieces of code. There is seamless 
#   integration between projects and version control.


######################################################################################
# 6. Basic Plotting in R and RStudio
######################################################################################

# R provides tools for producing publication quality plots of data. Visualizing data is
# even easier and more informative when using RStudio because of the way plots are 
# displayed, maintained and manipulated. In this section you will see how to make
# basic plots in R, how to navigate between your plots in RStudio, and how to use the
# "manipulate" package to make your RStudio plots interactive. You may want to do the first
# R tutorial before looking at this section.

# Basic Plotting and Plot History
# ===============================
# You can plot x-y data in R with the "plot" command. 
# For more information, run the line below:
?plot

# Now produce the following plots (and perhaps some others of your own):
x  = c(1:100)/10
y1 = x^2
y2 = exp(x)+exp(10-x)
plot(x,y1,'l')
plot(x,y2)
plot(x, sin(x), 'b')

# Look at the plots window (ctrl+6). Notice that the latest plot is displayed. You can also
# get the previous plots by making use of the blue arrows. It is also possible to zoom in and out
# on the plots and save them to different formats. Make sure you can use the plots window to 
# remove individual plots or clear the entire plot history as well!

# You will learn many other types of plotting in the course of this workshop, but they will all be
# displayed in the same way by RStudio, and all of them will be included in the plot history.


# Using the "manipulate" package
# ===============================
# To use the manipulate package, we first must load it. This can be done from the Packages tab
# or with the line below:
library(manipulate)

# The functionality is much the same as the "Manipulate" feature in Mathematica. 
# We wrap the plot statement in a manipulate clause, providing several sliders or buttons 
# or pickers to vary some interactive variable.
# An example:

x = cos(seq(0, 2*pi, 0.05))
y = sin(seq(0, 2*pi, 0.05))
manipulate(                # wrap plots in this to make it interactive  
  
  plot(                    # could use any plotting function here
    x, param*y,         # notice: param is not defined in advance, it will be set by the slider!    
    asp=1               # this just keeps the aspect ratio at 1, so that the shape of plot changes with param!
  ),
  param = slider(0,1)    # slider will provide the user with an option to change 'param' continuously  
)

# Run the above code and then go to the Plots window. Click on the small gear symbol in the top 
# right of this window. A slider appears that you can vary to change the shape of the plot. 
# This allows you to vary "param" in real time. It can be extremely useful for understanding 
# the effects of a parameter on a model!

# You can get more information on the manipulate function by getting help on it:
?manipulate


######################################################################################
# 7. Running the whole script
######################################################################################

# There are a few more options for running code in RStudio other than writing "Control+Enter"
# They are provided here with their shortcuts for completeness.
#     1. Run the ENTIRE script:                              "Control+Shift+R"
#     2. Run the script FROM THE BEGINNING UP TO THIS LINE:  "Control+Shift+B"
#     3. Run the script FROM THIS LINE TO THE END:           "Control+Shift+E"
# These can all be useful in different contexts. You can try them out by moving to various places in this
# script and typing these key combinations.

######################################################################################
# Appendix. List of useful RStudio Shortcut keys
######################################################################################

# [ For a COMPLETE list of keyboard shortuts type "Alt+H+K" ]

# Ctrl+1          (Move cursor to Editor)
# Ctrl+2          (Move cursor to Console)
# Ctrl+3          (Show workspace)
# Ctrl+Enter      (Editor: run a line, or a highlighted section of code)
# Ctrl+L          (clear the console)
# Ctrl+Up arrow   (Console: see list of previous commands; Editor: Go to top of file)
# Ctrl+Down arrow (Editor: Go to bottom of file)
# Ctrl+Shift+R    (Editor: Run the entire script)
# Ctrl+Shift+B    (Editor: Run the script from beginning to this point)
# Ctrl+Shift+E    (Editor: Run the script from this point to end)
# F1              (Editor: Get help on whatever is under the cursor)
# F2              (Editor: Show source code for whatever is under the cursor - if it exists)
# Ctrl+/          (Editor: Toggle Comment on selected region)
