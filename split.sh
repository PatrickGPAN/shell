#!/bin/bash

if [ -e $(date +%Y%m%d)_明细表.txt  ] 
then
	if [ -e $(date +%Y%m%d)持仓表.txt ]
	then
		if [ -e $(date +%Y%m%d)_成交表（升级后系统使用）.txt  ] 
		then
			if [ -e $(date +%Y%m%d)_执行表.txt ]
			then
				if [ -e $(date +%Y%m%d)表.txt  ] 
				then
					if [ -e $(date +%Y%m%d)_明细表.txt ]
					then
						#资管拆分
						value1=$(<'持仓拆分new\code\dl.txt')
						value2=$(<'持仓拆分new\code\zz.txt')
						
						cat $(date +%Y%m%d)_明细表.txt|head -n 4 >>1.txt
						cat $(date +%Y%m%d)_明细表.txt|gawk -F" " '$4~/('"$value1"')/'|sed $'s/$/\r/' >>2.txt
						cat 1.txt 2.txt >'dce_大连'.txt
						rm -f 1.txt 2.txt
						cat $(date +%Y%m%d)持仓表.txt|head -n 6 >>1.txt
						cat $(date +%Y%m%d)持仓表.txt|gawk -F" " '$1~/('"$value2"')/{getline a;print $0"\n"a}'|sed $'s/$/\r/' >>2.txt
						cat 1.txt 2.txt >'czce_郑州'.txt
						rm -f 1.txt 2.txt
						
						mkdir '资管持仓拆分'-`date -d "today" +"%Y%m%d"`
						mv dce_大连.txt '资管持仓拆分'-`date -d "today" +"%Y%m%d"`/
						mv czce_郑州.txt '资管持仓拆分'-`date -d "today" +"%Y%m%d"`/
						
						scp -r '资管持仓拆分'-`date -d "today" +"%Y%m%d"` \\持仓拆分new\\
						
						cj=$(<'\持仓拆分new\code1\cj.txt')
						qq=$(<'\持仓拆分new\code1\qq.txt')
						zh=$(<'\持仓拆分new\code1\zh.txt')
						fp=$(<'\持仓拆分new\code1\fp.txt')
						
						mkdir '期权数据'-`date -d "today" +"%Y%m%d"`
						
						#DL1
						cat $(date +%Y%m%d)_成交表（升级后系统使用）.txt|head -n 4 >>1.txt
						cat $(date +%Y%m%d)_成交表（升级后系统使用）.txt |gawk -F" " '$4~/('"$cj"')/'|sed $'s/$/\r/' >>2.txt
						cat 1.txt 2.txt >3.txt
						
						cat $(date +%Y%m%d)_成交表（升级后系统使用）.txt|tail -n 1|gawk -F" " '{print $1}' >>4.txt
						cat 3.txt 4.txt >5.txt
						
						mv 5.txt dce成交表（升级后系统使用）`date +%Y%m%d`.txt
						rm -f 1.txt 2.txt 3.txt 4.txt
						
						mv dce成交表（升级后系统使用）`date +%Y%m%d`.txt 期权数据-`date +%Y%m%d`/
						
						#DL2
						cat $(date +%Y%m%d)_执行表.txt|head -n 4 >>1.txt
						cat $(date +%Y%m%d)_执行表.txt|gawk -F" " '$3~/('"$qq"')/'|sed $'s/$/\r/' >>2.txt
						cat 1.txt 2.txt >3.txt
						
						cat $(date +%Y%m%d)_执行表.txt|tail -n 1|gawk -F" " '{print $1}' >>4.txt
						cat 3.txt 4.txt >5.txt
						
						mv 5.txt dce执行表`date +%Y%m%d`.txt
						rm -f 1.txt 2.txt 3.txt 4.txt
						
						mv dce执行表`date +%Y%m%d`.txt 期权数据-`date +%Y%m%d`/
						
						
						cat $(date +%Y%m%d)持仓表.txt|head -n 5 >>1.txt
						awk  'BEGIN{ RS="-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" }{if($1~"('"$zh"')")print $0;print "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" }' $(date +%Y%m%d)组合持仓表.txt|awk '{if($0!=line)print; line=$0}'|sed '/^$/d'|
						sed $'s/$/\r/' >>2.txt
						cat 1.txt 2.txt>>3.txt
						
						cat $(date +%Y%m%d)持仓表.txt|tail -9|head -1|gawk -F " " '{print $1}'|sed $'s/$/\r/' >>4.txt
						cat 3.txt 4.txt >>5.txt
						echo "===================================================================================================================================================================================">>5.txt
						
						mv 5.txt czce持仓表`date +%Y%m%d`.txt
						rm -f 1.txt 2.txt 3.txt 4.txt
						
						mv czce持仓表`date +%Y%m%d`.txt 数据-`date +%Y%m%d`/
						
						cat $(date +%Y%m%d)了结表.txt|head -n 5 >>1.txt
						awk  'BEGIN{ RS="------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" }{if($1~"('"$fp"')")print $0;print "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" }' $(date +%Y%m%d)非平仓了结表.txt|awk '{if($0!=line)print; line=$0}'|
						sed $'s/$/\r/' >>2.txt
						cat 1.txt 2.txt>>3.txt
						
						cat $(date +%Y%m%d)了结表.txt|tail -4|head -1|gawk -F " " '{print $1}'|sed $'s/$/\r/' >>4.txt
						cat 3.txt 4.txt >>5.txt
						echo "===================================================================================================================================================================================">>5.txt
						
						mv 5.txt czce了结表`date +%Y%m%d`.txt
						rm -f 1.txt 2.txt 3.txt 4.txt
						
						mv czce了结表`date +%Y%m%d`.txt 期权数据-`date +%Y%m%d`/
						
						scp -r 期权数据-`date +%Y%m%d` \\持仓拆分new\\
						
						mkdir '拆分'-`date -d "today" +"%Y%m%d"`
						dl=$(<'\持仓拆分new\code2\dl.txt')
						zz=$(<'\持仓拆分new\code2\zz.txt')
						
						cat $(date +%Y%m%d)_持仓明细表.txt|head -n 4 >>1.txt
						cat $(date +%Y%m%d)_持仓明细表.txt|gawk -F" " '$4~/('"$dl"')/'|sed $'s/$/\r/' >>2.txt
						cat 1.txt 2.txt >持仓明细表`date +%Y%m%d`.txt
						rm -f 1.txt 2.txt
						
						cat $(date +%Y%m%d)持仓表.txt|head -n 6 >>1.txt
						cat $(date +%Y%m%d)持仓表.txt|gawk -F" " '$1~/('"$zz"')/{getline a;print $0"\n"a}'|sed $'s/$/\r/' >>2.txt
						cat 1.txt 2.txt >持仓表`date +%Y%m%d`.txt
						rm -f 1.txt 2.txt
						
						mv 持仓明细表`date +%Y%m%d`.txt '拆分'-`date -d "today" +"%Y%m%d"`/
						mv 持仓表`date +%Y%m%d`.txt '拆分'-`date -d "today" +"%Y%m%d"`/
						
						scp -r '拆分'-`date -d "today" +"%Y%m%d"` \\持仓拆分new\\
					else
						echo '请检查明细表'
					fi
				else
					echo '请检查了结表'
				fi
			else
				echo '请检查执行表'
			fi
		else
			echo '请检查成交表'
		fi
	else
		echo '请检查持仓表'
	fi
else
	echo '请检查持仓明细表'
fi								
read var
