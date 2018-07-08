cd home/user
git clone https://github.com/meta-toolkit/meta.git
cd meta
git submodule update --init --recursive
mkdir build
cd build
cp ../config.toml .
cmake ../ -DCMAKE_BUILD_TYPE=Release
make
sed -i 's/xlocale/locale/' deps/icu-58.2/src/ExternalICU/source/i18n/digitlst.cpp
make
./unit-test --reporter=spec