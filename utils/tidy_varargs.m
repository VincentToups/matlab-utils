function v=tidy_varargs(v)
v = struct_to_varargs(varargs_to_struct(v));
