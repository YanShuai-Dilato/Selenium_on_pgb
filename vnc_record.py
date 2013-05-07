from castro import Castro
import subprocess,os,sys
from subprocess import Popen, PIPE, STDOUT
if __name__ == '__main__':	
	print 'launching slave process...'
	env = os.environ.copy()
	print env
	if sys.platform == "Darwin":
		c=Castro(display=1,passwd="/Users/labuser/.vinevncauth")
		c.start()
		ruby=subprocess.call(['rake'],env=env)
		c.stop()
	else:
		c=Castro(display=1)
		c=start()
		ruby=subprocess.call(['ruby','-S','rake'],env=env)
		c.stop()


