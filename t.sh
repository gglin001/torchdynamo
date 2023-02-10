pip install -vvv -e .

# cmake build debug library

objdump --syms torchdynamo/_eval_frame.so | grep debug
