## Troubleshoot the warning from events_summary join line 171
## The inner join should be one to one - each pid should only appear
## once in both data frames. Only happens with toy data?

cohorts %>% summarize(.by = pid, count = n()) %>% filter(count>1) %>% nrow()

# so 35 pid counted in both ibis and MIIA

db_count_pid  <- cohorts %>% summarize(.by = pid, count = n()) %>%
    filter(count>1) %>% distinct(pid)

report_full %>% filter(pid %in% db_count_pid$pid)  %>% select(pid, org_name)
events_full %>% filter(pid %in% db_count_pid$pid) %>% select(pid, org_name)

events_full %>%
    filter(str_detect(org_name, "Unicare")) %>% distinct(org_name)

events_full %>%
    filter(str_detect(org_name, "MIIA")) %>% distinct(org_name)

ibis_term %>% distinct(org_name)

MIIA_term %>% filter(pid %in% db_count_pid$pid)

ibis_event_summary %>% filter(pid %in% db_count_pid$pid)

ibis_event_summary %>% anti_join(MIIA_event_summary)

sum(ibis_patients_term$pid %in% MIIA_patients_term$pid)
sum(MIIA_patients_term$pid %in% ibis_patients_term$pid)


