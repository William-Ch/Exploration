#### output plot with transparent background ####
#create plot
ggplot() +
(...) +
theme(
  panel.background = element_rect(fill = 'transparent'),
  plot.background = element_rect(fill = 'transparent')
)

#save plot
ggsave(..., bg = 'transparent')
