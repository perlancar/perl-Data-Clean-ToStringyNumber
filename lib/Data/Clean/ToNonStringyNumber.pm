package Data::Clean::ToNonStringyNumber;

use 5.010001;
use strict;
use warnings;

use parent qw(Data::Clean::Base);

sub command_replace_with_non_stringy_number {
    require Scalar::Util;

    my ($self, $args) = @_;
    return '{{var}} = Scalar::Util::looks_like_number({{var}}) =~ /\\A(?:1|5|9|13)\\z/ ? {{var}}+0 : {{var}}';
}

sub new {
    my ($class, %opts) = @_;
    $opts{""} //= ['replace_with_non_stringy_number'];
    $class->SUPER::new(%opts);
}

sub get_cleanser {
    my $class = shift;
    state $singleton = $class->new;
    $singleton;
}

1;
# ABSTRACT: Convert stringy numbers in data to non-stringy numbers

=for Pod::Coverage ^(new|command_.+)$

=head1 SYNOPSIS

 use Data::Clean::ToNonStringyNumber;
 my $cleanser = Data::Clean::ToNonStringyNumber->get_cleanser;
 my $data     = ["a", 1, "1.2", []];
 my $cleaned  = $cleanser->clean_in_place($data); # -> ["a", 1, 1.2, []]


=head1 DESCRIPTION

This class can convert stringy numbers in your data to non-stringy ones.


=head1 METHODS

=head2 CLASS->get_cleanser => $obj

Return a singleton instance.

=head2 $obj->clean_in_place($data) => $cleaned

Clean $data. Modify data in-place.

=head2 $obj->clone_and_clean($data) => $cleaned

Clean $data. Clone $data first.


=head1 SEE ALSO

L<Data::Clean::ToStringyNumber>

=cut
