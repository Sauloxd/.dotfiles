mkdir ctags; cd ctags
curl -O http://www.thomashunter.name/wp-content/uploads/ctags-5.8.tar.gz
tar xzvf ctags-5.8.tar.gz
cd ctags-5.8
./configure
make
sudo make install
