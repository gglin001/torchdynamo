pip install -vvv -e .

# cmake build debug library
rm torchdynamo/_eval_frame.cpython*.so

objdump --syms torchdynamo/_eval_frame.so | grep debug

# objdump --syms torchdynamo/_guards.cpython-38-x86_64-linux-gnu.so | grep debug

pip install mypy

stubgen \
  -m torchdynamo._eval_frame \
  -o $PWD

# torchdynamo._guards
# ImportError: torchdynamo/_guards.so: undefined symbol: THPVariableClass
