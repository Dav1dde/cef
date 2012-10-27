# this script was made to simplify the translation process
# it will only work for CEF!


import re


CEF_VER = '3'

INCLUDE_RE = re.compile(r'\#include\s+"include/(?P<path>\w+)/(?P<name>\w+).h"')
def include_sub(match):
    path, name = match.group('path', 'name')

    if not path in ('capi', 'internal'):
        print 'WARNING: include/{}/{}.h - Leaving it unmodified'.format(path, name)
        return match.group(0)

    name = name.lstrip('cef_').rstrip('_capi')
    inc = '{}.{}'.format(path, name) if path == 'internal' else name

    return 'import deimos.cef{}.{};'.format(CEF_VER, inc)

PREPROCESS_RE = re.compile(r'\#(?P<instruction>ifndef|define|pragma|ifdef|endif|else|if|elif).*')
def preprocess_sub(match):
    all_, instruction = match.group(0, 'instruction')

    if instruction == 'define':
        if 'CEF_INCLUDE' in all_ and not 'defined(' in all_:
            return ''

        print 'WARNING: #define preprocessor macro - Leaving it unmodified'
        return all_

    return ''

EXTERN_C_RE = re.compile('extern\s+"C"\s+')
def extern_c_sub(match):
    return 'extern(C) '

TYPEDEF_RE = re.compile(r'typedef\s(?P<old>[^\s]+)\s+(?P<new>[^;]+);'
def typedef_sub(match):
    old, new = match.group('old', 'new')

    return 'alias {} {};'.format(old, new)

STRUCT_RE = re.compile(r'typedef\s+struct\s+(?P<name>\w+)')
def struct_sub(match):
    name = match.group('name')

    if not name.startswith('_'):
        print 'WARNING: struct name doesn\'t start with _, leaving it unmodified!'
        return match.group(0)

    return 'struct {}'.format(name[1:])

FUNC_RE = re.compile(r'CEF_EXPORT\s+(?P<ret>[\w, \s, \*]+)\s(?P<name>\w+)\((?P<args>[\w, \s, \*, \,, \), \(]*)\);')
def func_sub(match):
    ret, name, args = match.group('ret', 'name', 'args')

    return '{} {}({});'.format(ret, name, arg_cleanup(args))

CALLBACK_RE = re.compile(r'(?P<indent>\s*)(?P<ret>[\w, \s, \*]+)\s+\(CEF_CALLBACK\s\*(?P<name>\w+)\)\((?P<args>[\w, \s, \*, \,, \), \(]*)\);')
def callback_sub(match):
    indent, ret, name, args = match.group('indent', 'ret', 'name', 'args')
    
    return '{}extern(System) {} function({}) {};'.format(indent, ret_cleanup(ret), arg_cleanup(args), name);

CONST_RE = re.compile(r'const\s+(?P<name>\w+)+\*')
def const_sub(match):
    name = match.group('name')
    return 'const({})*'.format(name)

def arg_cleanup(args):
    args = ' '.join(args.split()) # a single space instead of multiple
    args = args.replace('struct _', '').replace('enum ', '');
    return CONST_RE.sub(const_sub, args);

ret_cleanup = arg_cleanup

BRACKET_RE = re.compile('\}[\s, \w]*;')
def bracket_sub(match):
    return '}'

def replace_all(s):
    s = EXTERN_C_RE.sub(extern_c_sub, s)
    s = INCLUDE_RE.sub(include_sub, s)
    s = PREPROCESS_RE.sub(preprocess_sub, s)
    s = TYPEDEF_RE.sub(typedef_sub, s)
    s = STRUCT_RE.sub(struct_sub, s)
    s = FUNC_RE.sub(func_sub, s)
    s = CALLBACK_RE.sub(callback_sub, s)
    s = CONST_RE.sub(const_sub, s)
    s = BRACKET_RE.sub(bracket_sub, s)

    return s


def main():
    from argparse import ArgumentParser
    from os.path import isdir, split as path_split, splitext
    from glob import glob

    parser = ArgumentParser()
    parser.add_argument('path', metavar='PATH')
    parser.add_argument('-i', '--inplace', dest='inplace', action='store_true')
    args = parser.parse_args()

    for path in glob(args.path):
        if isdir(path):
            print 'Skipping directory {}'.format(path)
            continue

        print 'Current file: {}'.format(path)
        with open(path) as f:
            new_header = replace_all(f.read())

        if not args.inplace:
            path += '_new'

        pre = ''
        if not new_header.startswith('module'):
            head, fname = path_split(path)
            mname = splitext(fname)[0].lstrip('cef_').rstrip('_capi')
            inc = '{}.{}'.format('internal', mname) if 'internal' in path else mname
            pre = 'module deimos.cef{}.{};\n\n'.format(CEF_VER, inc)

        with open(path, 'w') as f:
            f.write(pre)
            f.write(new_header)


if __name__ == '__main__':
    main()
    