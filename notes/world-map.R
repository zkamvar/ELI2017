library("ggplot2")
library("dplyr")
library("ggalt")
library("ggthemes")
ac <- 66.5
st <- 35.0
tc <- 23.5

x <- tibble::tribble(
	~climate, ~min, ~max,
	# "arctic", 66.6, 90,
	"temperate", 35.0, 66.5,
	"subtropical", 23.5, 35.0,
	"tropical", 0.0, 23.5
)

world <- map_data("world") %>%
	filter(region %in% c("China", "Mongolia", "USA", "Canada", "Mexico")) %>%
	mutate(climate = case_when(
		.$lat > 66.5 ~ "arctic",
		.$lat > 35.0 ~ "temperate",
		.$lat > 23.5 ~ "subtropical",
		TRUE         ~ "tropical"
	)) %>%
	tbl_df()

wide <- range(world$long)
wide <- seq(wide[1], wide[2], by = 1)
wide <- rep(wide, each = 4)
x <- x[rep(1:4, length(wide)/4), ]
x$x <- wide

ggplot(world, aes(x = long, y = lat, group = group)) +
  geom_ribbon(aes(x = x, ymin = min, ymax = max, fill = climate), data = x, inherit.aes = FALSE) +
	geom_path() +
  # scale_y_continuous(breaks = (-2:2) * 30) +
  # scale_x_continuous(breaks = (-4:4) * 45) +
	coord_map()
