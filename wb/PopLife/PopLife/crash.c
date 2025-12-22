/* An attempt to close the Output() file provided by the CLI. */
/* It is not more than that - it doesn't work (Guru FreeTwice from DOS) */

extern struct CommandLineInterface *_argcli;

/* extern long Input(), Output(), FindTask(), IsInteractive, Open(), Close(); */

main()
{
	long output, stdout, curout, nil;
	struct Process *proc;

	output = Output();
	curout = _argcli->cli_CurrentOutput;
	stdout = _argcli->cli_StandardOutput;
	proc   = FindTask(0L);

	if (_argcli->cli_Background && IsInteractive(stdout)) {
		Write(output, "Opening NIL:\n",  13L);
		nil = Open("NIL:", MODE_OLDFILE);
		Close(stdout);
		_argcli->cli_StandardOutput = nil;
		if (curout == stdout)
			_argcli->cli_CurrentOutput = nil;
		if (output == stdout) {
			proc->pr_COS = nil;
		}
		proc->pr_ConsoleTask = 0;
	}
}
