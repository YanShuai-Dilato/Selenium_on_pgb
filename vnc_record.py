from castro import Castro
import subprocess,os,sys
from subprocess import Popen, PIPE, STDOUT
if sys.platform == "darwin":
	print 'launching slave process...'
	env = os.environ.copy()
	env["PGBLANG"]="en_US"
	env["PGBBROWSER"]="firefox"
	print env
	print sys.platform
	c=Castro(display=1,passwd="/Users/labuser/.vinevncauth")

	c.start()
	ruby=subprocess.call(['rake'],env=env)

	env["PGBLANG"]="fr_FR"
	env["PGBBROWSER"]="chrome"
	print env
	print sys.platform
	ruby=subprocess.call(['rake'],env=env)
	c.stop()
else:
	if __name__ == '__main__':
		print 'launching slave process...'
		env = os.environ.copy()
		env["PGBLANG"]="en_US"
		env["PGBBROWSER"]="chrome"
		print env
		print sys.platform
		c=Castro(display=1)
		c.start()
		ruby=subprocess.call(['ruby','-S','rake'],env=env)
		env["PGBLANG"]="fr_FR"
		env["PGBBROWSER"]="firefox"
		print env
		print sys.platform
		ruby=subprocess.call(['ruby','-S','rake'],env=env)
		c.stop()
