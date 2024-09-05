from fixture import TestFixture

class TestExit(TestFixture):

    def test_exit(self):
        # empty command closes the program
        self.run_command("")

        # future commands fail
        with self.assertRaises(BrokenPipeError):
            self.run_command("e")
