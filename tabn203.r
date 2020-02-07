library(tidyverse)
library(tidyxl)
library(unpivotr)

tabn203.70 <- xlsx_cells("tabn203.70.xlsx")

tabn203.70 <- tabn203.70 %>% 
  mutate(character = trimws(character, whitespace = "[ \t\r\n.]"))

table <- tabn203.70 %>%
  filter(data_type != "blank") %>%
  filter(row != 4) %>%
  behead("NNW", table_name) %>%
  behead("NNW", year) %>%
  behead("NNW", race) %>%
  behead("W", state) %>%
  mutate(value = case_when(
    character == "---" ~ NA_real_,
    character == "#" ~ 0,
    TRUE ~ numeric
  )) %>%
  select(address, table_name, year, state, race, value)


write.csv(table, "tabn203_70.csv", row.names=FALSE)
