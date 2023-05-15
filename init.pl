#!/usr/bin/perl

use strict;
use warnings;

my $usage = "Usage: $0 [--option]\n\t ex. $0 --list\n";
if (@ARGV != 1) {
	print $usage;
	exit 1;
}

my $flag = shift;
my $home_dir = $ENV{"HOME"};
my $dotfiles_dir = "$home_dir/dotfiles";
my $config_dir = "$home_dir/.config";

my %dotfiles_hash = (
	zshrc => "zsh/.zshrc",
	zsh_aliases => "zsh/.zsh_aliases",
);

if ($flag eq '--list' || $flag eq '-l') {
	print "Symlinks:\n";
	while (my ($key, $value) = each(%dotfiles_hash)) {
		my $symlink = "$config_dir/$value";

		if (-l $symlink) {
			print "[x] $key\n";
		} else {
			print "[ ] $key\n";
		}
	}
} elsif ($flag eq '--sync' || $flag eq '-s') {
	while (my ($key, $value) = each(%dotfiles_hash)) {
		my $dotfile = "$dotfiles_dir/$value";
		my $symlink = "$config_dir/$value";
		my $app = substr($value, 0, index($value, '/'));
		my $app_dir = "$config_dir/$app";

		if (!-d $app_dir) {
			print "The directory '$app' does not exist in '$config_dir'\n";
		} elsif (-l $symlink) {
			print "The symlink for '$key' already exist\n";
		} elsif (-e $symlink) {
			print "A file named '$value' already exist\n";
		} else {
			unless (-e $dotfile) {
				print "The file '$dotfile' does not exist in the current directory\n";
				exit 1;
			}
			symlink($dotfile, $symlink) or die "Failed to create symlink: $!\n";
			print "Symlink for $key created successfully at $symlink\n";
		}
	}
} else {
	print $usage;
}


