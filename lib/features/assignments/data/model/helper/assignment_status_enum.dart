enum AssignmentState {
  //! Student States
  available, // status: 'assigned' && now < dueDate
  submitted, // status: 'handed_in'
  missed, // status: 'missed' OR (status: 'assigned' && now > dueDate)
  //! Instructor States
  onGoing, // status: 'ongoing'
  closed, // status: 'closed'
  //! Default
  unknown,
}

enum AssignmentStatus {
  assigned,
  handedIn,
  missed,
  ongoing,
  closed
  ;

  static AssignmentStatus fromString(String? value) {
    return switch (value) {
      'assigned' => AssignmentStatus.assigned,
      'handed_in' => AssignmentStatus.handedIn,
      'missed' => AssignmentStatus.missed,
      'ongoing' => AssignmentStatus.ongoing,
      'closed' => AssignmentStatus.closed,
      _ => AssignmentStatus.assigned,
    };
  }
}
