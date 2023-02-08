pip install -vvv -e .

# cmake build debug library

objdump --syms ptdynamo/eval_frame.so | grep debug
