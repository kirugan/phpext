#!/bin/bash
# Warning!!! I have not used this script for my extension development.
# Instead it's more like typed commands from bash history with comments.
echo "Start setup script";

# Step 1. Clone source repo (very slow probably wget master.zip is more appropriate 4 u)
git clone https://github.com/php/php-src.git;

# Step 2. Generate skeleton
cd php-src; cd ext;
./ext_skel --extname=my_extension --proto=./../../my_extension.def

# Step 3. Compile (the same steps as output from ext_skel)
cd ..;
vi ext/my_extension/config.m4;
# ^ remove dnl symbols at the beginning (they are comments)
# for this lines:
# dnl PHP_ARG_WITH(my_extension, for my_extension support,
# dnl Make sure that the comment is aligned:
# dnl [  --with-my_extension             Include my_extension support])
./buildconf;
./configure --with-my_extension;
# patience! it needs some time for first make:
make;
# after this you should see stub text that extension is working
./sapi/cli/php -f ext/my_extension/my_extension.php;

# Step 4. Modify & compile (see wiki at my repo to go through all caveats)
# you can copy my_extension.c from example dir
vi ext/my_extension/my_extension.c;
# it should be faster (compile only your extension cause make is smart)
make;

# Step 5. Goto step4 (loop)
