from castro import Castro
import subprocess,os
from subprocess import Popen, PIPE, STDOUT
print 'launching slave process...'
env = os.environ.copy()
print env
c=Castro(display=1,passwd="/Users/labuser/.vinevncauth")
c.start()
ruby = subprocess.call(['ruby','rake','TC_001'],env=env)
print ruby
c.stop()
