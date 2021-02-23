# Zabbix Scheduler
Sometimes you want to run external checks on your Zabbix server or proxy that take a long time.
Unfortunately, the default timout for checks in Zabbix is 3 seconds.
If a check takes longer, it will be marked as Unsupported.
You could change timeout value in the Zabbix configuration file, but this can have some unintended side effects (like network discovery taking 'forever').

Alternatively, we can use a simple script that will schedule an `at` job to kick-off the actual check script.
That script can then use `zabbix_sender` to report back it's values. This way, we work around the timeout problem entirely.

Provided are the scheduler script, a demo template and a demo script that shows you how to tie it al together.

For more info on why you would want to do this, see https://web.archive.org/web/20181110050205/http://zabbix.org/wiki/Escaping_timeouts_with_atd 
