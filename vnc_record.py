from castro import Castro
import subprocess,os,sys
from subprocess import Popen, PIPE, STDOUT
if sys.platform == "darwin":
	print 'launching slave process...'
	env = os.environ.copy()
	print env
	print sys.platform

	for x in range(1, 9):
		tc_name = "TC_%03d" % x # TC_001 TC_002 ... TC_008
		c=Castro(display=1, passwd="/Users/labuser/.vinevncauth", filename= tc_name + "_screencast.swf")
		c.start()
		print "ready to start"
		ruby = subprocess.Popen(['rake',tc_name],env=env)
		try:
			print "ready to wait"
			ruby.wait(timeout=3600)
		except:
			ruby.kill()
			ruby.wait()

		c.stop()
else:
	if __name__ == '__main__':
		print 'launching slave process...'
		env = os.environ.copy()
		print env
		print sys.platform
		for x in range(1, 9):
			tc_name = "TC_%03d" % x # TC_001 TC_002 ... TC_008
			c=Castro(display=1, filename= tc_name + "_screencast.swf")
			c.start()
			subprocess.call(['ruby','-S','rake',tc_name],env=env)
			c.stop()
