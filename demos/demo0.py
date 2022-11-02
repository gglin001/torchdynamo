from typing import List
import torch
import torchdynamo
import torch.fx


def my_compiler(gm: torch.fx.GraphModule, example_inputs: List[torch.Tensor]):
    print("my_compiler() called with FX graph:")
    gm.graph.print_tabular()
    return gm.forward


@torchdynamo.optimize(my_compiler)  # type: ignore
def fn(x, y):
    a = torch.cos(x)
    b = torch.sin(y)
    c = a + b
    # c.backward()
    # return c


fn(torch.randn(10, requires_grad=True), torch.randn(10, requires_grad=True))
