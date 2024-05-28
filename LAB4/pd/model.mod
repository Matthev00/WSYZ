set TASKS;
set LINKS within (TASKS cross TASKS);

param default_duration {TASKS} >= 0;
param min_duration {TASKS} >= 0;
param acc_cost {TASKS} >= 0;

param budget >= 0;

var start_time {TASKS} >= 0;
var real_duration {TASKS};
var total_time >= 0;
var task_budget {TASKS} >= 0, integer;
var end_time {TASKS} >= 0;
var reduction_units {TASKS} >= 0, integer;

minimize total_time_goal:
  total_time;

s.t. total_time_const {t in TASKS}:
  total_time >= end_time[t];

s.t. link_order_const {(f, s) in LINKS}:
 start_time[f] + real_duration[f] <= start_time[s];

s.t. real_duration_const {t in TASKS}:
 real_duration[t] = default_duration[t] - reduction_units[t];

s.t. duration_bounds {t in TASKS}:
  min_duration[t] <= real_duration[t] <= default_duration[t];

s.t. task_budget_const {t in TASKS}:
  task_budget[t] = reduction_units[t] * acc_cost[t];

s.t. budget_const:
  sum {t in TASKS} task_budget[t] <= budget;

s.t. end_time_const {t in TASKS}:
  start_time[t] + real_duration[t] = end_time[t];

