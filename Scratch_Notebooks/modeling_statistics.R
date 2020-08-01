library(ggplot2)

statlines_5 = read.csv("true_and_predicted_statlines_5.csv", stringsAsFactors = FALSE)
statlines_10 = read.csv("true_and_predicted_statlines_10.csv", stringsAsFactors = FALSE)

statlines_5 = statlines_5[500:length(statlines_5),]
statlines_10 = statlines_10[500:length(statlines_10),]

statlines_5$h = statlines_5$location_x == "HOME"
statlines_10$h = statlines_10$location_x == "HOME"

statlines_5$rebounds_x = statlines_5$offensive_rebounds_x + statlines_5$defensive_rebounds_x
statlines_10$rebounds_x = statlines_10$offensive_rebounds_x + statlines_10$defensive_rebounds_x
statlines_5$made_two_point_field_goals_x = statlines_5$made_field_goals_x - statlines_5$made_three_point_field_goals_x
statlines_10$made_two_point_field_goals_x = statlines_10$made_field_goals_x - statlines_10$made_three_point_field_goals_x

rebounds_lm_5 = lm(rebounds_x ~ offensive_rebounds_y + defensive_rebounds_y, data = statlines_5)
rebounds_lm_10 = lm(rebounds_x ~ offensive_rebounds_y + defensive_rebounds_y, data = statlines_10)
ft_lm_5 = lm(made_free_throws_x ~ attempted_free_throws_y + attempted_field_goals_y + h, data = statlines_5)
ft_lm_10 = lm(made_free_throws_x ~ attempted_free_throws_y + attempted_field_goals_y + h, data = statlines_10)
twopt_lm_5 = lm(made_two_point_field_goals_x ~ attempted_two_point_field_goals_y + attempted_field_goals_y + Opponent.Defensive.Rating, data = statlines_5)
twopt_lm_10 = lm(made_two_point_field_goals_x ~ attempted_two_point_field_goals_y + attempted_field_goals_y + Opponent.Defensive.Rating, data = statlines_10)
threept_lm_5 = lm(made_three_point_field_goals_x ~ attempted_three_point_field_goals_y + Opponent.Defensive.Rating + Team.Pace, data = statlines_5)
threept_lm_10 = lm(made_three_point_field_goals_x ~ attempted_three_point_field_goals_y + Opponent.Defensive.Rating + Team.Pace, data = statlines_10)
ast_lm_5 = lm(assists_x ~ assists_y + blocks_y, data = statlines_5)
ast_lm_10 = lm(assists_x ~ assists_y + blocks_y, data = statlines_10)
blocks_lm_5 = lm(blocks_x ~ offensive_rebounds_y + defensive_rebounds_y + blocks_y + Team.Defensive.Rating, data = statlines_5)
blocks_lm_10 = lm(blocks_x ~ offensive_rebounds_y + defensive_rebounds_y + blocks_y + Team.Defensive.Rating, data = statlines_10)
steals_lm_5 = lm(steals_x ~ steals_y + Opponent.Turnover.., data = statlines_5)
steals_lm_10 = lm(steals_x ~ steals_y + Opponent.Turnover.., data = statlines_10)
turnovers_lm_5 = lm(turnovers_x ~ turnovers_y + assists_y + Opponent.Defensive.Rating, data = statlines_5)
turnovers_lm_10 = lm(turnovers_x ~ turnovers_y + assists_y + Opponent.Defensive.Rating, data = statlines_10)
