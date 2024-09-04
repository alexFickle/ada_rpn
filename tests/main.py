import os
import unittest
import argparse
import typing
import fixture


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("binary", help="the binary being tested")
    args = parser.parse_args()
    binary = typing.cast(str, args.binary)

    fixture.set_test_binary(binary)

    loader = unittest.TestLoader()
    test_dir = os.path.dirname(os.path.realpath(__file__))
    suite = loader.discover(test_dir)
    runner = unittest.TextTestRunner()
    runner.run(suite)

if __name__ == '__main__':
    main()
