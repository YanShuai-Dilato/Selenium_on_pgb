from castro import Castro
import subprocess
from subprocess import Popen, PIPE, STDOUT
print 'launching slave process...'
c=Castro(display=1,passwd="/Users/labuser/.vinevncauth")
c.start()
ruby = subprocess.call(['ruby','rake','TC_001'])
print ruby
c.stop()
