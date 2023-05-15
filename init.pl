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
	print "Existing symlinks:\n";
	while (my ($key, $value) = each(%dotfiles_hash)) {
		my $symlink = "$config_dir/$value";

		if (-l $symlink) {
			print "[x] $key\n";
		} else {
			print "[ ] $key\n";
		}
	}
} elsif ($flag eq '--sync' || $flag eq '-s') {
	# Creating symlinks in '.config/' for all the dotfiles
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

	# If created symlink for .zshrc in .config/zsh. Create file for sourcing it.
	my $localZshrc =  "$home_dir/.zshrc";
	if (-l "$config_dir/zsh/.zshrc" && !-l $localZshrc) {
		if (-e $localZshrc) {
			print "\n$localZshrc exists. Backing up and recreating.\n";
			rename($localZshrc, "$home_dir/.zshrc.bak");
		}
		symlink("$dotfiles_dir/.zshrc", $localZshrc);
		print "Symlink for $localZshrc created successfully\n";
	}
	print "\n========================\n";
	print "Dotfile sync completed.\n";
	print "========================\n";
} else {
	print $usage;
}



