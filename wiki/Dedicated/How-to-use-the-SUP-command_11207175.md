SUP Command
We created the sup command (previously the command_bridge) to make it easier to diagnose common configuration issues, as well as stop and start applications.
Get the configured whapps for this node:
/opt/kazoo/utils/sup/sup whapps_config get whapps_controller whapps

Get the currently running whapps:
/opt/kazoo/utils/sup/sup whapps_controller running_apps

Get list of freeswitch nodes that ecallmgr is configured to connect to:
:
/opt/kazoo/utils/sup/sup -n ecallmgr ecallmgr_config get fs_nodes

Get list of freeswitch nodes that ecallmgr is connected to
:
/opt/kazoo/utils/sup/sup -n ecallmgr ecallmgr_maintenance list_fs_nodes
Restart a whapp on a remote host:
/opt/kazoo/utils/sup/sup -h apps002-dev-vb.2600hz.com -c change_me whapps_controller restart_app crossbar

Check the running whapps on a remote host:
/opt/kazoo/utils/sup/sup -h apps002-dev-vb.2600hz.com -c change_me whapps_controller running_apps

Check which amqp host this server is connected to:
/opt/kazoo/utils/sup/sup amqp_mgr get_host

Flush the whapps_config cache:
(in case you modified some settings such as FS nodes)
/opt/kazoo/utils/sup/sup whapps_config flush

You can also use this command for any document in the system_config database, for example:
 /opt/kazoo/utils/sup/sup whapps_config flush number_manager
Flush the ecallmgr_config cache:
(in case you modified some settings such as FS nodes)
/opt/kazoo/utils/sup/sup -n ecallmgr ecallmgr_config flush
Add FS nodes to ecallmgr:
This command adds a FreeSWITCH node to the currently running ecallmgr, but it does not update the persistent configuration.
/opt/kazoo/utils/sup/sup -n ecallmgr ecallmgr_maintenance add_fs_node freeswitch@hostname.mydomain.com

Migrate (update) database documents:
/opt/kazoo/utils/sup/sup -t 3600 whapps_maintenance migrate
Flush whistle_apps couch cache:
/opt/kazoo/utils/sup/sup whistle_couch_maintenance flush
Restart conference whapp
/opt/kazoo/utils/sup/sup whapps_controller restart_app conference
Stop the whistle_apps erlang VM
/opt/kazoo/utils/sup/sup erlang halt
or
/opt/kazoo/utils/sup/sup -n whistle_apps erlang halt
Stop the ecallmgr erlang VM
/opt/kazoo/utils/sup/sup -n ecallmgr erlang halt
Alias the sup command:
(for the user you are logged as)
/opt/kazoo/utils/sup/add_alias.sh
Lookup an account via the realm:
/opt/kazoo/utils/sup/sup crossbar_maintenance find_account_by_realm 83a99b.sip.mydomain.com
Lookup an account via the phone number:
/opt/kazoo/utils/sup/sup crossbar_maintenance find_account_by_number 4158867900
Find out which carrier will be used for a DID:
 /opt/kazoo/utils/sup/sup stepswitch_maintenance process_number 4158867900  
Flush the wh_cache (to refresh the schemas for example)
/opt/kazoo/utils/sup/sup wh_cache flush
Manually create the first account on a Kazoo system:
( change the values for ACCOUNT_NAME, REALM, USERNAME, PASSWORD)
/opt/kazoo/utils/sup/sup crossbar_maintenance create_account ACCOUNT_NAME REALM USERNAME PASSWORD
Reload stepswitch to update carriers manually:
/opt/kazoo/utils/sup/sup stepswitch_maintenance reload_resources
Reload a module:
/opt/kazoo/utils/sup/sup crossbar_maintenance start_module cb_braintree
List all crossbar running modules:
/opt/kazoo/utils/sup/sup crossbar_maintenance running_modules
List crossbar bindings:
/opt/kazoo/utils/sup/sup crossbar_bindings modules_loaded
Refresh whapps after update:
/opt/kazoo/utils/sup/sup whapps_maintenance refresh
(whapps_maintenance refresh can not be done in some circumstances from the foreground, it will try to output status info to a shell that has already closed and will error. The command is valid but not via sup if the command needs to output data. Use blocking_refresh)
Blocking Refresh whapps:
/opt/kazoo/utils/sup/sup whapps_maintenance blocking_refresh
Increase the log level for whapps:
/opt/kazoo/utils/sup/sup whistle_maintenance syslog_level debug
Increase the log level for ecallmgr:
/opt/kazoo/utils/sup/sup -n ecallmgr whistle_maintenance syslog_level debug
You can use any of the 
syslog severity levels
 to change what is logged.
Show the nodes sharing the same Rabbitmq:
/opt/kazoo/utils/sup/sup whistle_maintenance nodes
 
Display Registrations status:
/opt/kazoo/utils/sup/sup -n ecallmgr ecallmgr_maintenance registrar_summary
 
RabbitMQ broker related commands:
sup whistle_amqp_maintenance primary_broker
sup whistle_amqp_maintenance broker_summary
sup whistle_amqp_maintenance connection_summary
 
Manipulate the ACLs
sup -necallmgr ecallmgr_maintenance allow_carrier CarrierName CarrierIP
sup -necallmgr ecallmgr_maintenance allow_carrier CarrierName CIDR
sup -necallmgr ecallmgr_maintenance allow_sbc SBCName SBCIP 
sup -necallmgr ecallmgr_maintenance deny_carrier CarrierName CarrierIP 
sup -necallmgr ecallmgr_maintenance deny_sbc SBCName SBCIP 
sup -necallmgr ecallmgr_maintenance remove_acl CarrierName|SBCName
sup -necallmgr ecallmgr_maintenance carrier_acls list_acls
sup -necallmgr ecallmgr_maintenance sbc_acls list_acls
sup -necallmgr ecallmgr_maintenance reload_acls -
 issues a reloadacl on all FreeSWITCH servers 
sup -necallmgr ecallmgr_maintenance flush_acls -
 just flushes the caches, not FreeSWITCH
Flush all cached docs for all accounts:
/opt/kazoo/utils/sup/sup couch_mgr flush_cache_docs
Flush all cached docs for a specific account:
/opt/kazoo/utils/sup/sup couch_mgr flush_cache_docs account%2Fab%2Fcd%2Fefghi
/opt/kazoo/utils/sup/sup couch_mgr flush_cache_docs accounts
FOR DEVELOPMENT TESTING: Hot load (no restart needed) a minor code change. Example for a change to file /opt/kazoo/applications/jonny5/src/j5_limits.erl
cd /opt/kazoo/applications/jonny5/
make
/opt/kazoo/utils/sup/sup whistle_maintenance hotload j5_limits # changed source file without path or extension
Make an account a reseller account. Be careful with this. It affects all it's children and grandchildren, etc...
Expirement in a test account tree of accounts.
sup whistle_services_maintenance make_reseller 
account_id
/*<![CDATA[*/
div.rbtoc1478561759210 {padding: 0px;}
div.rbtoc1478561759210 ul {list-style: disc;margin-left: 0px;}
div.rbtoc1478561759210 li {margin-left: 0px;padding-left: 0px;}

/*]]>*/
Get the configured whapps for this node:
Get the currently running whapps:
Get list of freeswitch nodes that ecallmgr is configured to connect to::
Get list of freeswitch nodes that ecallmgr is connected to:
Restart a whapp on a remote host:
Check the running whapps on a remote host:
Check which amqp host this server is connected to:
Flush the whapps_config cache:
Flush the ecallmgr_config cache:
Add FS nodes to ecallmgr:
Migrate (update) database documents:
Flush whistle_apps couch cache:
Restart conference whapp
Stop the whistle_apps erlang VM
Stop the ecallmgr erlang VM
Alias the sup command:
Lookup an account via the realm:
Lookup an account via the phone number:
Find out which carrier will be used for a DID:
Flush the wh_cache (to refresh the schemas for example)
Manually create the first account on a Kazoo system:
Reload stepswitch to update carriers manually:
Reload a module:
List all crossbar running modules:
List crossbar bindings:
Refresh whapps after update:
Blocking Refresh whapps:
Increase the log level for ecallmgr:
Show the nodes sharing the same Rabbitmq:
Display Registrations status:
RabbitMQ broker related commands:
Manipulate the ACLs
Flush all cached docs for all accounts:
Flush all cached docs for a specific account:
FOR DEVELOPMENT TESTING: Hot load (no restart needed) a minor code change. Example for a change to file /opt/kazoo/applications/jonny5/src/j5_limits.erl
Make an account a reseller account. Be careful with this. It affects all it
s children and grandchildren, etc...