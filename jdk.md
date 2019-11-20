sudo tar xzf ~/Downloads/jdk-8u101-linux-x64.tar.gz
mv jdk... /usr/local/jdk


vim /etc/profile

JAVA_HOME=/usr/local/jdk
CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar 
PATH=$JAVA_HOME/bin:$HOME/bin:$HOME/.local/bin:$PATH
export JAVA_HOME CLASSPATH PATH

vim ~/.bashrc

source /etc/profile

JAVA_HOME=/usr/local/jdk
CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar 
PATH=$JAVA_HOME/bin:$HOME/bin:$HOME/.local/bin:$PATH
export JAVA_HOME CLASSPATH PATH

source ~/.bashrc
