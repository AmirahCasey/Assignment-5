library(here)
library(tidyverse)
library(patchwork)
library(png)
library(ggplot2)

#read in the data 

data<-(read_csv(here("data", "siscowet.csv")))

data<- data %>% filter(!sex=="NA")

head(data)

#create an exploratory figure from the data 

# I want to create a figure that has two panels: 1 showing the lengths and weights of females, 
#and one showing males

females<- data %>% filter(sex=="F") %>% filter(!sex=="NA")

p1<- ggplot(data = females, aes(x= len, y= wgt)) + 
  geom_point()

males<- data %>% filter(sex=="M") %>% filter(!sex=="NA")

p2<- ggplot(data = males, aes(x= len, y= wgt)) + 
  geom_point() 

exploratory<- p1+p2

ggsave(exploratory, 
       filename = here("figures", "exploratory.pdf"),  
       device = "pdf",
       dpi = 300, 
       width = 10, 
       height = 6)  


#expository figure 
library(png)
trout <- readPNG('data/sisco.png', native=TRUE)
part1<- ggplot(data, aes(x = len, fill = sex)) + 
  geom_histogram(binwidth = 20, position = "dodge") +  
  theme_minimal() +
  xlab("Length (mm)") + 
  ylab("Count") +
  ggtitle("Sex Difference Between Siscowet Lake Trout Length") +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank())


finalfig<- part1 + inset_element(trout, 0.8, 0.7, 0.77, 0.9, align_to = 'panel')

  
ggsave(finalfig, 
       filename = here("figures", "expository.pdf"),  
       device = "pdf",
       dpi = 300, 
       width = 10, 
       height = 6)  

       