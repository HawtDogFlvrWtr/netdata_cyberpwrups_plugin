# no need for shebang - this file is loaded from charts.d.plugin
# SPDX-License-Identifier: GPL-3.0+

# netdata
# real-time performance and health monitoring, done right!
# (C) 2016 Costa Tsaousis <costa@tsaousis.gr>
#

# how frequently to collect UPS data
cyberups_update_every=10

# the priority of cyberups related to other charts
cyberups_priority=90000

cyberups_get() {
	sudo pwrstat -status
}

cyberups_check() {

# this should return:
#  - 0 to enable the chart
#  - 1 to disable the chart

	#require_cmd pwrstat -status || return 1

    cyberups_get >/dev/null
    if [ $? -ne 0 ]
    then
        error "CyberPower UPS is not online."
	return 1
    else
	return 0
    fi
}

cyberups_create() {

        # create the charts
        cat <<EOF
CHART cyberups.charge '' "UPS Charge" "percentage" ups cyberups.charge area $((cyberups_priority + 1)) $cyberups_update_every
DIMENSION battery_charge charge absolute 1 100
                                                                                                                                                                                                                   
CHART cyberups.input_voltage '' "UPS Input Voltage" "Volts" input cyberups.input.voltage line $((cyberups_priority + 4)) $cyberups_update_every
DIMENSION input_voltage voltage absolute 1 100

CHART cyberups.output_voltage '' "UPS Output Voltage" "Volts" output cyberups.output.voltage line $((cyberups_priority + 4)) $cyberups_update_every
DIMENSION output_voltage voltage absolute 1 100
                                                                                                                                                                                                                   
CHART cyberups.load '' "UPS Load" "percentage" ups cyberups.load area $((cyberups_priority)) $cyberups_update_every
DIMENSION load load absolute 1 100
                                                                                                                                                                                                                   
CHART cyberups.time '' "UPS Time Remaining" "Minutes" ups cyberups.time area $((cyberups_priority + 2)) $cyberups_update_every
DIMENSION time time absolute 1 100
                                                                                                                                                                                                                   
EOF
        return 0
}
                                                                                                                                                                                                                   
                                                                                                                                                                                                                   
cyberups_update() {
        # the first argument to this function is the microseconds since last update
        # pass this parameter to the BEGIN statement (see bellow).
                                                                                                                                                                                                                   
        # do all the work to collect / calculate the values
        # for each dimension
        # remember: KEEP IT SIMPLE AND SHORT
                                                                                                                                                                                                                   
        cyberups_get | awk "
                                                                                                                                                                                                                   
BEGIN {
        battery_charge = 0;
        power_rating = 0;
        input_voltage = 0;
        output_voltage = 0;
        load = 0;
        time = 0;
}
/.*Battery.*/   { battery_charge = \$3 * 100};
/.*Rating.*Power.*/ { power_rating = \$3 }
/.*Utility.*/    { input_voltage = \$3 * 100};
/.*Output.*/     { output_voltage = \$3 * 100 };
/.*Load.*/      { load = \$2 / power_rating * 100 * 100};
/.*Remaining.*/  { time = \$3 * 100 };
END {
	print \"BEGIN cyberups.charge $1\";
	print \"SET battery_charge = \" battery_charge;
	print \"END\"

	print \"BEGIN cyberups.input_voltage $1\";
	print \"SET input_voltage = \" input_voltage;
	print \"END\"

	print \"BEGIN cyberups.output_voltage $1\";
	print \"SET output_voltage = \" output_voltage;
	print \"END\"

	print \"BEGIN cyberups.load $1\";
	print \"SET load = \" load;
	print \"END\"

	print \"BEGIN cyberups.time $1\";
	print \"SET time = \" time;
	print \"END\"
}"
        if [ $? -ne 0 ]
        then
            failed=$((failed + 1))
        	error "failed to get values for Cyber Power UPS ${host} on ${cyberups_sources[${host}]}" && return 1
        else
            working=$((working + 1))
        fi

	[ $working -eq 0 ] && error "failed to get values from all Cyber Power UPSes" && return 1

	return 0
}
