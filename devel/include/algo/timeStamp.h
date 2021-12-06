// Generated by gencpp from file algo/timeStamp.msg
// DO NOT EDIT!


#ifndef ALGO_MESSAGE_TIMESTAMP_H
#define ALGO_MESSAGE_TIMESTAMP_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace algo
{
template <class ContainerAllocator>
struct timeStamp_
{
  typedef timeStamp_<ContainerAllocator> Type;

  timeStamp_()
    : time_stamp(0.0)  {
    }
  timeStamp_(const ContainerAllocator& _alloc)
    : time_stamp(0.0)  {
  (void)_alloc;
    }



   typedef double _time_stamp_type;
  _time_stamp_type time_stamp;





  typedef boost::shared_ptr< ::algo::timeStamp_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::algo::timeStamp_<ContainerAllocator> const> ConstPtr;

}; // struct timeStamp_

typedef ::algo::timeStamp_<std::allocator<void> > timeStamp;

typedef boost::shared_ptr< ::algo::timeStamp > timeStampPtr;
typedef boost::shared_ptr< ::algo::timeStamp const> timeStampConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::algo::timeStamp_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::algo::timeStamp_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::algo::timeStamp_<ContainerAllocator1> & lhs, const ::algo::timeStamp_<ContainerAllocator2> & rhs)
{
  return lhs.time_stamp == rhs.time_stamp;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::algo::timeStamp_<ContainerAllocator1> & lhs, const ::algo::timeStamp_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace algo

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::algo::timeStamp_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::algo::timeStamp_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::algo::timeStamp_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::algo::timeStamp_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::algo::timeStamp_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::algo::timeStamp_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::algo::timeStamp_<ContainerAllocator> >
{
  static const char* value()
  {
    return "1b5e4ee2dd9c99a9b543c72da6261542";
  }

  static const char* value(const ::algo::timeStamp_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x1b5e4ee2dd9c99a9ULL;
  static const uint64_t static_value2 = 0xb543c72da6261542ULL;
};

template<class ContainerAllocator>
struct DataType< ::algo::timeStamp_<ContainerAllocator> >
{
  static const char* value()
  {
    return "algo/timeStamp";
  }

  static const char* value(const ::algo::timeStamp_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::algo::timeStamp_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float64 time_stamp\n"
"\n"
"\n"
"\n"
"\n"
;
  }

  static const char* value(const ::algo::timeStamp_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::algo::timeStamp_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.time_stamp);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct timeStamp_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::algo::timeStamp_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::algo::timeStamp_<ContainerAllocator>& v)
  {
    s << indent << "time_stamp: ";
    Printer<double>::stream(s, indent + "  ", v.time_stamp);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ALGO_MESSAGE_TIMESTAMP_H
