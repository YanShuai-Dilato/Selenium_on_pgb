from castro import Castro
import subprocess,os,sys
from subprocess import Popen, PIPE, STDOUT
if sys.platform == "darwin":
	print 'launching slave process...'
	env = os.environ.copy()
	print env
	print sys.platform
	c=Castro(display=1,passwd="/Users/labuser/.vinevncauth",filename = "TC-001-screencast.swf")
	c.start()
	ruby=subprocess.call(['rake','TC_001'],env=env)
	print ruby
	c.stop()
	c=Castro(display=1,passwd="/Users/labuser/.vinevncauth",filename = "TC-002-screencast.swf")
	c.start()
	ruby=subprocess.call(['rake','TC_002'],env=env)
	print ruby
	c.stop()
else:
	if __name__ == '__main__':
		print 'launching slave process...'
		env = os.environ.copy()
		print env
		print sys.platform
		c=Castro(display=1)
		c.start()
		ruby=subprocess.call(['ruby','-S','rake'],env=env)
		c.stop()
