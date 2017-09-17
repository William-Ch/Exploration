library(ggmap)
library(dplyr)
dataset <- read.csv('~/Council/CRU Bluetooth/Route visualisation test.csv')
dataset <- arrange(dataset, Corridor, index)
qmap(location = 'brisbane', zoom = 14, color = 'bw') +
  geom_path(data = dataset, aes(x = longitude, y = latitude, group = Corridor, colour = Corridor), size = 2)


ggmap(
  get_map(
    location = c(lon = mean(dataset$longitude), lat = mean(dataset$latitude)),
    zoom = 14,
    maptype = 'roadmap',
    color = 'bw'
  )
) +
  geom_path(data = dataset, aes(x = longitude, y = latitude, group = Corridor, colour = Corridor), size = 2, show.legend = F) +
  labs(xlab = 'Longitude', ylab = 'Latitude')
