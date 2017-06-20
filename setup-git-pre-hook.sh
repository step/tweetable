#!/bin/sh
echo "
#!/bin/sh
red='\\\033[0;31m'
white='\\\033[1;37m'
b=\$(rubocop -D)
exit_code=\$?
if [[ \$exit_code != 0 ]]; then
 echo "\"\\\n \\\t \\\t \\\t \${red}Ooops!!!\""
 echo "\"\\\tYou seems to have voilated few code conventions.\""
 echo "\"\\\tMake sure you have fixed them before commiting your changes\""
 echo "\"\\\tRun \${white}rubocop -D\${red} to know about the voilated conventions\""
 exit \$exit_code
fi
" > .git/hooks/pre-commit

chmod +x .git/hooks/pre-commit

# Run this file to activate the git hook by running
#` chmod 400 setup-git-pre-hook.sh ;sh setup-git-pre-hook.sh `
